class Folder < ApplicationRecord
  has_many_attached :files

  belongs_to :parent_folder, class_name: "Folder",
    foreign_key: "folder_id", optional: true

  validates :name, presence: true
end
