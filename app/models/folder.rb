class Folder < ApplicationRecord
  belongs_to :parent_folder, class_name: "Folder",
    foreign_key: "folder_id", optional: true

  validates :name, presence: true
end
