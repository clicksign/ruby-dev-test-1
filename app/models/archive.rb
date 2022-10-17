class Archive < ApplicationRecord
  belongs_to :folder
  has_one_attached :file

  validates :name, presence: true, uniqueness: { scope: :folder }
  validates :file, presence: true
end
