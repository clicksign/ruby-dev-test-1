class UploadService

  def initialize(options = {})
    @upload = options
    @blob_list = []

    generate_direct_uploads(@upload)
  end

  def generate_direct_uploads(options)
    files = options['undefined']
    files.each do |file|
      create_blob(file)
    end

    send_files(signed_objects)

    signed_objects
  end

  def create_blob(file_blob_args)
    new_blob = -> (file_blob_args) {
      blob_object = ActiveStorage::Blob.create_before_direct_upload!(
        filename: file_blob_args[1]['file_name'],
        byte_size: file_blob_args[1]["byte_size"],
        checksum: file_blob_args[1]["checksum"]
      )
      file_id = SecureRandom.uuid
      blob_object.update_attribute(:key, "uploads/#{file_id}/")
      @blob_list.push(blob_object)
    }

    new_blob.call(file_blob_args)
    @blob_list
  end

  def signed_objects
    @response_signed_list = []
    @blob_list.each do |blob|
      expiration_time = 10.minutes
      signer_object = response_signature(
        blob.service_url_for_direct_upload(expires_in: expiration_time),
        headers: blob.service_headers_for_direct_upload
      )

      @response_signed_list.push({ signer_object: signer_object, blob_signed_id: blob.signed_id })
    end
    @response_signed_list
  end

  def response_signature(url, **params)
    {
      direct_upload: {
        url: url
      }.merge(params)
    }
  end

  private

  def send_files(signed_objects)
    puts "at send_files #{signed_objects}"
  end

end