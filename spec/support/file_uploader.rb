module FileUploader
  def create_file_blob(filename: 'img.png', content_type: 'image/png', metadata: nil)
    ActiveStorage::Blob.create_and_upload! io: file_fixture(filename).open, filename: filename,
                                           content_type: content_type, metadata: metadata
  end
end

RSpec.configure do |config|
  config.include FileUploader
end
