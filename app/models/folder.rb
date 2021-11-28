class Folder < ApplicationRecord
  has_many_attached :documents

  has_many :children, class_name: "Folder",
                          foreign_key: "parent_id",
                          dependent: :destroy

  belongs_to :parent, class_name: "Folder", optional: true

  validates :name, presence: true

  scope :root , -> { where(parent_id: nil) }
  scope :children , ->(folder_id) { where(parent_id: folder_id) }
  

end