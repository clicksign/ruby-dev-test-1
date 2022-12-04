# frozen_string_literal: true

class FileUpload < ApplicationRecord
  # Validates
  validates :description, presence: true, uniqueness: { case_sensitive: false }
  has_many_attached :files
end
