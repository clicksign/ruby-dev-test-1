class Folder < ApplicationRecord
  belongs_to :parent, class_name: "Folder", optional: true
  has_many :child_folders, class_name: "Folder", foreign_key: :parent_id

  validates :name, presence: true, uniqueness: { scope: :parent }
end
