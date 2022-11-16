class UploadService

  def initialize(options = {})
    create_upload(options)
  end

  private

  def create_upload(upload)
    serialize_files = -> (files) {
      files.map { |file| {io: file.path, filename: file.original_filename, content_type: file.content_type} }
    }

    object_upload = {
      title: upload[:title],
      info: {
        path: upload[:info][:path],
        files: serialize_files.call(upload[:info][:files])
      }
    }

    UploadJob.perform_later(object_upload)
  end

end