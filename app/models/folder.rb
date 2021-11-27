class Folder < ApplicationRecord
  has_many_attached :documents

  has_many :children, class_name: "Folder",
                          foreign_key: "parent_id"

  belongs_to :parent, class_name: "Folder", optional: true

  validates :name, presence: true

end