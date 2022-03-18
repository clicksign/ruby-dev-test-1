class Folder < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :parent_folder_id, case_sensitive: false }

  belongs_to :parent_folder, class_name: 'Folder', foreign_key: 'parent_folder_id', required: false
  has_many :subfolders, class_name: 'Folder', foreign_key: 'parent_folder_id', dependent: :destroy
  has_many :documents, dependent: :destroy

  default_scope { order(:name) }
  scope :root_folders, -> { where(parent_folder_id: nil) }
end
