class FileResource < ApplicationRecord
  belongs_to :folder
  has_one_attached :file

  validates :name, {
    presence: true,
    uniqueness: {scope: :folder_id, case_sensitive: false}
  }
  validates :folder, presence: true

  def breadcrumbs
    folder.breadcrumbs + '/' + name
  end
end
