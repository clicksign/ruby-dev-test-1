class Document < ApplicationRecord
  # associations

  belongs_to :folder, optional: true
  belongs_to :file_system
  has_one_attached :file

  # validations

  validates :name, presence: true, length: { minimum: 3 }
  validates :name, uniqueness: { scope: [:file_system_id, :folder_id] }, if: :name_changed?
  validates :file, presence: true
  validate :file_systems_should_match, if: :folder_id?

  # scopes

  scope :root, -> { where(folder: nil) }

  # callbacks

  before_validation :normalize_filename, :normalize_file_system

  private

  def normalize_filename
    return unless file.attached?

    if name
      file.filename = name
    else
      self.name = file.filename
    end
  end

  def normalize_file_system
    return if file_system_id || !folder_id

    self.file_system_id = folder.file_system_id
  end

  def file_systems_should_match
    if file_system_id != folder.file_system_id
      errors.add(:file_system, :invalid)
    end
  end
end
