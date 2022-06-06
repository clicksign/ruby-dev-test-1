class Document < ApplicationRecord
  before_validation :set_name

  belongs_to :folder, optional: true

  has_one_attached :file

  validates :file, presence: true
  validates :name,
            length: { maximum: 255 },
            uniqueness: { scope: :folder_id, case_sensitive: false }

  private

  def set_name
    self.name = file.filename.to_s if name.blank?
  end
end
