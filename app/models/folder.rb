class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', foreign_key: 'parent_folder_id', required: false
  has_many :child_folders, class_name: 'Folder', foreign_key: 'parent_folder_id'
end
