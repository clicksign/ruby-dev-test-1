class Folder < ApplicationRecord
  belongs_to :parent, :class_name => 'Folder'
  has_many :subfolders, :class_name => 'Folder', foreign_key: 'parent_id'

end
