class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder',
                      foreign_key: 'parent_id',
                      required: false
  has_many :folders, foreign_key: 'parent_id'
  has_many_attached :archives
end
