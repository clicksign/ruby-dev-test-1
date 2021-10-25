class Directory < ApplicationRecord
  belongs_to :parent, class_name: 'Directory', optional: true
  has_many :subdirectory, class_name: 'Directory', foreign_key: 'parent_id'
  has_many :documents

  validates :name, presence: true
  validates :name, uniqueness: true
end
