class Directory < ApplicationRecord
  ## ASSOCIATIONS
  has_many :archives, dependent: :destroy
  has_many :child_directories, class_name: "Directory", foreign_key: :parent_id, dependent: :destroy

  belongs_to :parent, class_name: "Directory", optional: true

  ## VALIDATES
  validates :name, presence: true
end
