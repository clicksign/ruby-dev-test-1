class Directory < ApplicationRecord
  belongs_to :parent, class_name: 'Directory', optional: true
  has_many :subdirectories, class_name: 'Directory', foreign_key: :parent_id, inverse_of: :parent

  has_many_attached :files

  validates :name, presence: true
end
