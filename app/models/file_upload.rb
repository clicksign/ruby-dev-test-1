# frozen_string_literal: true

class FileUpload < ApplicationRecord
  # Validates
  validates :description, presence: true, uniqueness: { case_sensitive: false }
  has_many_attached :files

  belongs_to :parent, class_name: 'FileUpload', optional: true

  has_many :sub_directories, class_name: 'FileUpload',
                             foreign_key: :parent_id, dependent: :destroy

  scope :only_parents, -> { where(parent_id: nil) }

  def parent?
    parent_id.nil?
  end

  def sub_directories?
    !parent?
  end
end
