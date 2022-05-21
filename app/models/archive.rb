class Archive < ApplicationRecord
  ## ASSOCIATIONS
  belongs_to :directory

  ## ACTIVE STORAGE
  has_one_attached :file

  ## VALIDATES
  validates :name, presence: true
  validates :file, presence: true
end
