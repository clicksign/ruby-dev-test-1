class Directory < ApplicationRecord
  has_many :children, class_name: "Directory", foreign_key: "parent_id", dependent: :destroy
  belongs_to :parent, class_name: "Directory", optional: true
  has_many_attached :files, dependent: :destroy
  validates :name, presence: true
end
