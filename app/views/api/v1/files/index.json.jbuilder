json.array! @directory.files do |file|
  json.id file.id
  json.filename file.blob.filename
  json.content_type file.blob.content_type
  json.byte_size file.blob.byte_size
  json.path rails_blob_path(file, path_only: true)
end
