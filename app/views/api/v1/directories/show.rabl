object @directory
attributes :id, :name, :directories, :archives
child(:directory) do
  attributes :id, :name
end