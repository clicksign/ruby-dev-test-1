# frozen_string_literal: true

class Directory < ApplicationRecord
  # Association
  belongs_to :parent, class_name: 'Directory', foreign_key: 'directory_id', optional: true

  has_many :subdirectories, class_name: 'Directory'
  has_many :documents

  # Validations
  validates :name, presence: true
end
