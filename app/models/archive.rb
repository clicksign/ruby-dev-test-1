# frozen_string_literal: true

class Archive < ApplicationRecord
  belongs_to :folder, optional: true
  has_one_attached :file

  validates :name, presence: true
  validates :name, length: { maximum: 100 }
  validates :name, uniqueness: { scope: :folder_id }

  after_validation :update_path

  def update_path
    self.path = '/'
    self.path = "#{folder.path}#{folder.name}/" if folder.present?
  end
end
