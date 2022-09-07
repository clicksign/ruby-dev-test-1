# frozen_string_literal: true

# File
class Document < ApplicationRecord
  has_one_attached :file, dependent: :delete_all
  belongs_to :folder

  delegate :attachment, to: :file, allow_nil: false

  validates :title, presence: true

  validate :check_file_presence

  def check_file_presence
    errors.add(:file, 'no added') unless file.attached?
  end
end
