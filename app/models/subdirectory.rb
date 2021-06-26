class Subdirectory < ApplicationRecord
  belongs_to :directory

  validates :name, presence: true
end
