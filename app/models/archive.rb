class Archive < ApplicationRecord
  belongs_to :directory
  has_many_attached :data

  validates :name, presence: true
end
