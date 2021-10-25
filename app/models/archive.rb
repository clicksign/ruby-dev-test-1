class Archive < ApplicationRecord
  has_one_attached :file
  belongs_to :directory
end
