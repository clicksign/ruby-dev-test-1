class Bind < ApplicationRecord
  belongs_to :child, class_name: "Directory"
  belongs_to :parent, class_name: "Directory"

  validates :parent_id, presence: true
  validates :child_id, presence: true
end
