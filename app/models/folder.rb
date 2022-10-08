class Folder < ApplicationRecord
  belongs_to :parent_folder, class_name: "Folder", optional: true
  has_many :folders, class_name: "Folder", foreign_key: "parent_folder_id"

  validates_presence_of :name
end
