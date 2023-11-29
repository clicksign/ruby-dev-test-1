# frozen_string_literal: true

class Folder < ApplicationRecord
  module Associations
    extend ActiveSupport::Concern
    included do
      belongs_to :parent, class_name: 'Folder', optional: true
      has_many :child_folders, class_name: 'Folder', foreign_key: 'parent_id', dependent: :destroy
      has_many :documents, dependent: :destroy
    end
  end
end
