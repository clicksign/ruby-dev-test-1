class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder',
                      foreign_key: 'parent_id',
                      required: false
  has_many :folders
  has_many_attached :archives
end
