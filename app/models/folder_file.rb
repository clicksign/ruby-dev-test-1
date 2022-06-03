# frozen_string_literal: true

class FolderFile < ApplicationRecord
  belongs_to :folder, optional: true

  has_one_attached :file, dependent: :destroy
  validate :file_name_is_unique_in_folder, if: proc { file.attached? }

  scope :roots, -> { where(folder_id: nil) }

  private

  def file_name_is_unique_in_folder
    return unless FolderFile.joins(file_attachment: :blob)
                            .exists?(
                              folder_id: folder_id,
                              active_storage_blobs: {
                                filename: file.filename.to_s
                              }
                            )

    errors.add(:file, "File with name #{file.filename} already exists in folder")
  end
end
