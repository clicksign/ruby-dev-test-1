# frozen_string_literal: true

class FolderInput < Upgrow::Input
  attribute :name
  attribute :folder_id

  validates :name, presence: true
  validate :validate_folder_id

  def validate_folder_id
    return if folder_id.nil?

    errors.add(:folder_id, :invalid) unless FolderRepository.exists(folder_id)
  end
end
