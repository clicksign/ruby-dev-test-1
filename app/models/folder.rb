# frozen_string_literal: true

class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', optional: true

  has_many :folder_files, dependent: :restrict_with_error
  has_many :parents, class_name: 'Folder', foreign_key: 'parent_id', dependent: :restrict_with_error,
                     inverse_of: :parent

  validates :name, presence: true, uniqueness: { scope: :parent_id, case_sensitive: false } # rubocop:disable Rails/UniqueValidationWithoutIndex
  validate :parent_is_not_self, :parent_exists, if: proc { |folder| folder.parent_id.present? }

  scope :roots, -> { where(parent_id: nil) }
  scope :children_of, ->(folder) { where(parent_id: folder.id) }
  scope :ordered_by_name, ->(direction = :asc) { order(name: direction) }

  delegate :name, to: :parent, prefix: true, allow_nil: true

  private

  def parent_is_not_self
    errors.add(:parent, 'cannot be self') if parent_id == id
  end

  def parent_exists
    errors.add(:parent, 'does not exist') unless Folder.exists?(parent_id)
  end
end
