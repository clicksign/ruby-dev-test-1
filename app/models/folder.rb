class Folder < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :parent_folder_id, case_sensitive: false }

  belongs_to :parent_folder, class_name: 'Folder', foreign_key: 'parent_folder_id', required: false
  has_many :subfolders, class_name: 'Folder', foreign_key: 'parent_folder_id', dependent: :destroy
  has_many_attached :documents

  validate :documents_filename

  scope :root_folder, -> { where(name: 'root').first_or_create(name: 'root') }

  private

  def documents_filename
    folder_filenames = documents.map{ |document| document.filename.to_s }
    unless folder_filenames.uniq.length == folder_filenames.length
      errors.add(:base, 'Filename has already been taken')
    end
  end
end
