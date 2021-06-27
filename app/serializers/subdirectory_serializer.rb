class SubdirectorySerializer < ActiveModel::Serializer
  attributes :id, :name, :archive_urls

  belongs_to :directory
end
