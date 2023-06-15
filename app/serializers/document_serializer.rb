class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :name, :directory_id, :file
end
