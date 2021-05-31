class DirectorySerializer
  include JSONAPI::Serializer
  attributes :id, :name, :ancestry, :files

  attribute :subdirectories do |object|
    object.children.order(name: :asc).map { |d| SubdirectorySerializer.new(d) }
  end

  attribute :files do |object|
    object.files.map { |file| FileSerializer.new(file.blob) }
  end
end
