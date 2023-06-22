# frozen_string_literal: true

class ArchiveSerializer < ActiveModel::Serializer
  attributes :id, :name, :folder_id, :path, :url
end
