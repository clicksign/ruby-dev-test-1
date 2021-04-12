if @directory.errors.present?
  json.errors @directory.errors
else
  json.directory @directory
end
