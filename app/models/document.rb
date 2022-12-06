# frozen_string_literal: true

class Document < ApplicationRecord
  # Association
  belongs_to :directory, optional: true

  # Attachments
  has_one_attached :file

  # Validations
  validates :name, :file, presence: true
end
