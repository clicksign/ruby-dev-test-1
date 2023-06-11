class Directory < ApplicationRecord
  belongs_to :parent, class_name: "Directory", optional: true

  has_many :subdir, class_name: "Directory", foreign_key: "parent_id"
end
