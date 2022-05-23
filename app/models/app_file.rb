class AppFile < ApplicationRecord
  belongs_to :app_folder
  has_one_attached :file_content

  validates :file_content, presence: true
end
