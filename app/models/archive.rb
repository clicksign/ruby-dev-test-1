class Archive < ApplicationRecord
  has_one_attached :file
  # has_one_attached :file, service: :s3

  belongs_to :directory

  validates_presence_of :name
end