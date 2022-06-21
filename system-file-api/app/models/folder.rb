# frozen_string_literal: true

class Folder < ApplicationRecord
  has_many :childrens, class_name: 'Folder',
                       foreign_key: 'parent_id', dependent: :restrict_with_exception
  belongs_to :parent, class_name: 'Folder', optional: true
end
