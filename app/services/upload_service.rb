class UploadService

  def initialize(options = {})
    @upload = options
    @response_signed_list = []
    @blob_list = []

    generate_direct_uploads(@upload)
  end

  def generate_direct_uploads(options)
    files = options['undefined']
    files.keys.each do |key|
      create_blob(files[key])
    end

    send_files(signed_objects)
  end

  def create_blob(file_blob_args)
    new_blob = -> (file) {
      blob_object = ActiveStorage::Blob.create_before_direct_upload!(
        filename: file['file_name'],
        byte_size: file["byte_size"],
        checksum: file["checksum"],
        content_type: file['content_type']
      )

      create_upload('fooo title')

      file_id = SecureRandom.uuid
      blob_object.update_attribute(:key, "uploads/#{file_id}/")
      @blob_list.push({ blob_object: blob_object, file: file['file'] })
    }

    new_blob.call(file_blob_args)
  end

  def signed_objects
    @response_signed_list
    @blob_list.each do |blob|
      expiration_time = 10.minutes

      sign_object = response_signature(
        blob[:blob_object].service_url_for_direct_upload(expires_in: expiration_time),
        headers: blob[:blob_object].service_headers_for_direct_upload
      )

      @response_signed_list.push({
          file: blob[:file],
          signed_object: sign_object,
          blob_signed_id: blob[:blob_object].signed_id,
          content_type: blob[:blob_object][:content_type]
        })
    end

    @response_signed_list
  end

  def response_signature(url, params)
    {
      direct_upload: {
        url: url
      }.merge(params)
    }
  end

  private

  def send_files(signed_objects)
    UploadJob.perform_later(signed_objects)
    puts "\n\n[√] creating job"
  end

  def create_upload(title)
    upload = Upload.create!(title: title, info: { })
    if upload.save!
      puts 'upload saved'
      # upload.file.attach()
    end
  end

end