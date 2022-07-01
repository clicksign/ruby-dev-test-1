class Archive < ApplicationRecord
  has_one_attached :file
  belongs_to :folder

  validates :name, presence: true, uniqueness: { scope: :folder_id }
  validates_presence_of :file
end
