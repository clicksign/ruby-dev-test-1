class Document < ApplicationRecord
  has_one_attached :file
  belongs_to :folder

  validates :name, uniqueness: { scope: :folder_id }
end
