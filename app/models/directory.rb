class Directory < ApplicationRecord
  has_many :subdirectories

  validates :name, presence: true
end
