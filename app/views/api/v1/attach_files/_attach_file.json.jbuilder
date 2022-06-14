json.extract! attach_file, :id, :name, :folder_id
json.file attach_file.file
json.url api_v1_attach_file_url(attach_file, format: :json)
