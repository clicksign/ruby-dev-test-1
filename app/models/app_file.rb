class AppFile < ApplicationRecord
  belongs_to :app_folder
  has_one_attached :file_content

  validates :file_content, presence: true

  scope :root_files, -> { where(app_folder_id: nil) }
end
