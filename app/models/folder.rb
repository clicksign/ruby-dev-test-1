class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder' , optional: true
  has_many :sub_folders, class_name: 'Folder', foreign_key: 'parent_id', dependent: :destroy
  has_many :attach_files, dependent: :destroy

end
