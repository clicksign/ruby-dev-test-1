class Archive < ApplicationRecord
  has_one_attached :file
  
  belongs_to :folder, inverse_of: :archives

  validates :name, presence: true, uniqueness: { scope: :folder_id }
  validates :file, presence: true
end
