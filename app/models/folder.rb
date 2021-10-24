class Folder < ApplicationRecord
  has_many :child_folders, class_name: 'Folder',
                           foreign_key: 'parent_folder_id',
                           dependent: :destroy

  belongs_to :parent_folder, class_name: 'Folder', optional: true

  validates :name, presence: true
end
