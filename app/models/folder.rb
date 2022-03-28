class Folder < ApplicationRecord
  has_many :subfolders, class_name: "Folder",
                          foreign_key: "parent_folder_id"

  belongs_to :parent_folder, class_name: "Folder", optional: true

  has_many_attached :files

  validates :name, presence: true
end
