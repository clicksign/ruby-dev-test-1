class Folder < ApplicationRecord
  has_many_attached :files
  before_destroy :delete_files

  belongs_to :parent_folder, class_name: "Folder",
    foreign_key: "folder_id", optional: true

  validates :name, presence: true
  validate :folder_exists

  def delete_files
    self.files.each { |f| f.purge }
  end

  def folder_exists
    errors.add(
      :folder_id,
      "Folder does not exist"
    ) if folder_id.present? && !Folder.find_by(id: folder_id).present?
  end
end
