# frozen_string_literal: true

def blob_file(path, name, content_type)
  ActiveStorage::Blob.create_after_upload!(
    io: File.open(path, 'rb'),
    filename: name,
    content_type: content_type
  ).signed_id
end
