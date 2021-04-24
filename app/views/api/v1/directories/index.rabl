collection @directories, object_root: false
attributes :id, :name, :directories
child(:directory) do
  attributes :id, :name
end
