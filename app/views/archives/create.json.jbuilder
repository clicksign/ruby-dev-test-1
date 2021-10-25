json.data do
  json.name @archive.name
  json.directory "#{@archive.directory&.path}/#{@archive.name}"
  json.file @archive.file
end
