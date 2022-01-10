json.directories do
  json.array! @directories, :id, :name, :parent_id, :subdirectories, :files
end