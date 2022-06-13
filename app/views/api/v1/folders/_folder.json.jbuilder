json.extract! folder, :id, :name, :permission, :parent_id, :created_at, :updated_at
json.attach_files folder.attach_files, partial: "api/v1/attach_files/attach_file", as: :attach_file
json.url api_v1_folder_url(folder, format: :json)
