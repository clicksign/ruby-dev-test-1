# frozen_string_literal: true

class Directory < ApplicationRecord
  validates :name, presence: true

  has_many :file_objects, dependent: :destroy
  has_many :directories, foreign_key: :parent_directory_id
  belongs_to :parent_directory, class_name: 'Directory', optional: true

  def path
    return name if parent_directory.blank?

    "#{parent_directory.path}/#{name}"
  end
end
