class UploadService

  def initialize(options = {})
    create_upload(options)

    response_upload
  end

  private

  def create_upload(upload)
    serialize_files = -> (uc) {
      # files.map { |file| {io: file, filename: file.original_filename, content_type: file.content_type} }
      uc['info']['files'].map { |file| ActiveStorage::Blob.create_before_direct_upload!(
        key: "uploads/#{uc['info']['path']}/#{SecureRandom.uuid}/",
        filename: file['file_name'],
        content_type: file['content_type'],
        checksum: nil,
        byte_size: nil
      ) }
    }

    @object_upload = {
      title: upload[:title],
      info: {
        path: upload[:info][:path],
        files: serialize_files.call(upload)
      }
    }

    UploadJob.perform_later(@object_upload)
  end

  def response_upload
    {
      direct_upload: @object_upload.except(:files)
    }
  end

end