class FolderSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :children, if: -> { object.association(:children).loaded? }
  has_many :files, if: -> { object.association(:files_attachments).loaded? }, serializer: FileSerializer
end
