json.extract! attach_file, :id, :name, :folder_id, :created_at, :updated_at
json.url attach_file_url(attach_file, format: :json)
