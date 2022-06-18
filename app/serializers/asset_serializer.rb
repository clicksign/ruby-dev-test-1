class AssetSerializer
  include JSONAPI::Serializer
  attributes :name

  attribute :path do |object|
    "#{NodePath.new(object.node).path}/#{object.name}.#{object.file.filename.to_s.split('.').last}"
  end
end
