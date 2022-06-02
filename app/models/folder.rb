# frozen_string_literal: true

class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', optional: true

  validates :name, presence: true, uniqueness: { case_sensitive: false } # rubocop:disable Rails/UniqueValidationWithoutIndex
  validate :parent_is_not_self, :parent_exists, if: proc { |folder| folder.parent_id.present? }

  scope :roots, -> { where(parent_id: nil) }

  private

  def parent_is_not_self
    errors.add(:parent, 'cannot be self') if parent_id == id
  end

  def parent_exists
    errors.add(:parent, 'does not exist') unless Folder.exists?(parent_id)
  end
end
