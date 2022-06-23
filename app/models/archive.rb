class Archive < ApplicationRecord
  belongs_to :folder, optional: true
  has_one_attached :data

  validates :name, presence: true, length: { minimum: 3, maximum: 64 }
  validates :name, uniqueness: { scope: :folder }, if: -> { name_changed? || folder_id_changed? }
  validates :size, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
