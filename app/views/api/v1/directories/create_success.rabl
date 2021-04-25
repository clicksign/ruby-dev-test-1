object @directory
attributes :id, :name, :directories
child(:directory) do
  attributes :id, :name
end