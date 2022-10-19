require 'active_support'

class DocumentSerializer < ActiveModel::Serializer
  attributes :id, :name, :content

  attribute(:file) { object.file.url }
  attribute(:size) { ActiveSupport::NumberHelper.number_to_human_size(object.file.byte_size) }
  attribute(:folder) { object.folder.attributes }
end
