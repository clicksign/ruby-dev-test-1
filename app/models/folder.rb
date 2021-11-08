class Folder < ApplicationRecord
  belongs_to :folder, optional: true
  has_many :items, dependent: :destroy
  has_many :subfolders, class_name: "Folder", foreign_key: "root_id"
end
