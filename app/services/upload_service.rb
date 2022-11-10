class UploadService

  def initialize(options = {})
    @upload = options
    @blob_list = []

    generate_direct_uploads(@upload)
  end

  def generate_direct_uploads(options)

    # params['upload']['info']['files'].size must be great then one
    # todo: validation file array size

    files = options['upload']['info']['files']
    files.each do |file|
      create_blob(file)
    end

    response = signed_urls
    response
  end

  def create_blob(blob_args)
    new_blob = -> (file) {
      blob_object = ActiveStorage::Blob.create_before_direct_upload!(
        filename: "nome_do_arquivo", byte_size: file['byte_size'], checksum: file['checksum']
      )
      file_id = SecureRandom.uuid

      # byebug
      blob_object.update_attribute(:key, "uploads/#{file_id}/")

      @blob_list.push(blob_object)
    }

    new_blob.call(blob_args)

    @upload_list
  end

  def signed_urls
    @response_signed_list = []
    @blob_list.each do |blob|
      expiration_time = 10.minutes
      signer_url = response_signature(
        blob.service_url_for_direct_upload(expires_in: expiration_time),
        headers: blob.service_headers_for_direct_upload
      )

      @response_signed_list.push({signer_url: signer_url, blob_signed_id: blob.signed_id})

      @response_signed_list
    end
  end

  def response_signature(url, **params)
    {
      direct_upload: {
        url: url
      }.merge(params)
    }
  end

end