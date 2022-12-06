# frozen_string_literal: true

class Document < ApplicationRecord
  # Association
  belongs_to :directory, optional: true

  # Validations
  validates :name, presence: true
end
