class Folder < ApplicationRecord
  has_many :child_folders, class_name: 'Folder',
                           foreign_key: 'parent_folder_id',
                           dependent: :destroy

  belongs_to :parent_folder, class_name: 'Folder', optional: true

  has_many_attached :archives

  validates :name, presence: true

  def is_root_folder?
    !parent_folder.present?
  end
end
