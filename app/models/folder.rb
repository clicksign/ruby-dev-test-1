class Folder < ApplicationRecord
  has_ancestry

  # associations

  belongs_to :file_system
  has_many :documents, dependent: :destroy

  # validations

  validates :name, presence: true, length: { minimum: 3 }
  validates :name, uniqueness: { scope: :ancestry }, if: :name_changed?
  validate :file_systems_should_match, if: :parent_id?

  # scopes

  scope :root, -> { where(ancestry: "/") }

  # callbacks

  before_validation :normalize_file_system

  # methods

  def pathname
    path.pluck(:name).join(" / ")
  end

  private

  def normalize_file_system
    return if file_system_id || !parent_id

    self.file_system_id = parent.file_system_id
  end

  def file_systems_should_match
    if file_system_id != parent.file_system_id
      errors.add(:file_system, :invalid)
    end
  end
end
