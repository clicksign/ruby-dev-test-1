class Upload < ApplicationRecord
  belongs_to :folder
  has_one_attached :file

  validates :file, presence: true
  validate :unique_name_and_type_to_folder

  def unique_name_and_type_to_folder   
    #add type 
    total_same_name_and_type_in_folder = ActiveStorage::Attachment.where(record_type: self.class.name, record_id: self.folder.upload_ids).includes(:blob).where(blob: {filename: self.file.blob.filename.to_s}).count
    self.errors.add(:file, "A file with the same name already exists in this folder. Please change the file name before uploading") if total_same_name_and_type_in_folder > 0
  end
end
