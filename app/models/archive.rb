# frozen_string_literal: true

class Archive < ApplicationRecord
  belongs_to :directory
  has_one_attached :file

  validates :name, :file, :directory, presence: true
  validates_uniqueness_of :name, scope: :directory_id
  validate :acceptable_file

  private

  def acceptable_file
    return unless file.attached?

    acceptable_types = ['image/jpeg', 'image/png', 'text/plain']
    acceptable_types.include?(file.content_type) || errors.add(:file, 'must be a JPEG, PNG or TXT')
  end
end
