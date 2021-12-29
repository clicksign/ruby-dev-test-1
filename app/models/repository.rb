# frozen_string_literal: true

class Repository < ApplicationRecord
  self.inheritance_column = 'type'

  belongs_to :origin, class_name: 'Repository', optional: true

  has_one :storage, dependent: :destroy
  accepts_nested_attributes_for :storage

  validates :name, presence: true
  validates :type, presence: true

  validate :origin_folder

  scope :by_type, ->(type) { where(type: type) if type.present? }

  private

  def origin_folder
    errors.add(:origin, 'The source cannot be a file.') if origin&.type == 'Archive'
  end
end
