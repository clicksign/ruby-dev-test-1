class Directory < ApplicationRecord
  has_many :subdirectories, dependent: :destroy
  has_many_attached :archives

  validates :name, presence: true
end
