# frozen_string_literal: true

class RepositorySerializer < ActiveModel::Serializer
  attributes :id, :type, :name

  has_one :origin
end
