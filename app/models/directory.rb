class Directory < ApplicationRecord
  has_many :documents, dependent: :delete_all
  has_many :sub_directories, class_name: "Directory", foreign_key: "parent_id", dependent: :delete_all
  belongs_to :parent, class_name: "Directory", foreign_key: "parent_id", optional: true

  validates_presence_of :name, :path, :size
end
