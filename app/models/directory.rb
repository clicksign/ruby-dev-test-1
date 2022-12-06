# frozen_string_literal: true

class Directory < ApplicationRecord
  # Association
  belongs_to :parent, class_name: 'Directory', foreign_key: 'directory_id', optional: true
  has_many   :subfolders, class_name: 'Directory'

  # Validations
  validates :name, presence: true
end
