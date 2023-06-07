class Archive < ApplicationRecord
  belongs_to :folder

  validates_presence_of :name
  validates :name, uniqueness: { scope: [:folder_id] }

  has_one_attached :file
end
