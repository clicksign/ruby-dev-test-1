# frozen_string_literal: true

class Directory < ApplicationRecord
  has_many :file_items, dependent: :destroy
  belongs_to :parent, class_name: 'Directory', optional: true
  has_many :subdirectories, class_name: 'Directory',
                            foreign_key: 'parent_id', dependent: :destroy, inverse_of: :directory

  has_one_attached :content
end
