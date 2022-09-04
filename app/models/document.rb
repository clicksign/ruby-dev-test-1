# frozen_string_literal: true

# File
class Document < ApplicationRecord
  has_one_attached :file

  delegate :attachment, to: :file, allow_nil: true

  validates :title, presence: true
  validates :description, presence: true

  validate :check_file_presence

  def check_file_presence
    errors.add(:file, 'no file added') unless file.attached?
  end
end
