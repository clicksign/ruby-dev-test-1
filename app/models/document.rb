class Document < ApplicationRecord
  belongs_to :directory
  has_one_attached :file
  validates :name, presence: true
  validates :name, uniqueness: true
end
