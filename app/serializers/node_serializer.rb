class NodeSerializer
  include JSONAPI::Serializer
  attributes :name, :parent, :children

  attribute :childs do |object|
    "#{object.name} (2020)"
  end
end
