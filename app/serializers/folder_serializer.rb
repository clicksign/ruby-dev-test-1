class FolderSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :children, if: -> { object.association(:children).loaded? }
end
