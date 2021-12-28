# frozen_string_literal: true

class Repository < ApplicationRecord
  self.inheritance_column = 'type'

  belongs_to :origin, class_name: 'Repository', optional: true

  validates :name, presence: true
  validates :type, presence: true

  validate :origin_folder

  private

  def origin_folder
    errors.add(:origin, 'The source cannot be a file.') if origin.type == 'Archive'
  end
end
