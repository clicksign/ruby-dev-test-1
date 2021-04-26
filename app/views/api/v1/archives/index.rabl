collection @archives, object_root: false
attributes :id, :name
child(:directory) do
  attributes :id, :name
end
