class Subdirectory < ApplicationRecord
  belongs_to :directory
  has_many_attached :archives

  validates :name, presence: true
end
