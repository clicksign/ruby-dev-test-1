require 'active_support'

class FolderSerializer < ActiveModel::Serializer
  attributes :id, :name, :parent_id
  attribute(:size) { object.trusted_sized ? ActiveSupport::NumberHelper.number_to_human_size(object.byte_size) : 'Calculating' }
  attribute(:childen) { object.children }
  attribute(:documents) { object.documents.map(&:attributes) }

  # cannot limit the amout of childen nor documents that appear in the result,
  # being possible to slow down the api because of it,
  # if some folder has an absurd amout of children or documents (or both)
end
