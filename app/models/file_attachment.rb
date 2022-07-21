class FileAttachment < ApplicationRecord
  belongs_to :folder
  has_many_attached :files

  validates :name, {
    presence: true,
    uniqueness: {scope: :folder_id, case_sensitive: false}
  }

  validates :folder, presence: true

  def file_path
    folder.print_work_directory + '/' + name
  end
end