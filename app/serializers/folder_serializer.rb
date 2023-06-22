# frozen_string_literal: true

class FolderSerializer < ActiveModel::Serializer
  attributes :id, :parent_folder_id, :name, :path

  has_many :archives
end
