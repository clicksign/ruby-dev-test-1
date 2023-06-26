class Document < ApplicationRecord
  # associations

  belongs_to :folder, optional: true
  belongs_to :file_system
  has_one_attached :file

  # validations

  validates :name, presence: true
  validates :file, presence: true

  # callbacks

  before_validation :normalize_filename

  private

  def normalize_filename
    return unless file.attached?

    if name
      file.filename = name
    else
      self.name = file.filename
    end
  end
end
