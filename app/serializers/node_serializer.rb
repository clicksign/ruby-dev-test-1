class NodeSerializer
  include JSONAPI::Serializer
  attributes :name, :parent, :children  
end
