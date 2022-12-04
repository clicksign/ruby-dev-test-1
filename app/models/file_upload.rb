# frozen_string_literal: true

class FileUpload < ApplicationRecord
  # Validates
  validates :description, presence: true, uniqueness: { case_sensitive: false }
end
