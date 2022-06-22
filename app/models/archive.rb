# frozen_string_literal: true

class Archive < ApplicationRecord
  include Nameable
  validate :check_file_attached

  belongs_to :parent, class_name: 'Directory', inverse_of: 'archives'

  has_one_attached :file

  after_validation :update_full_path

  def update_full_path
    return unless parent && name.present?

    self.full_path = "#{parent.full_path}/#{name}"
  end

  private

  def check_file_attached
    errors.add(:file, 'Please upload the file.') unless file.attached?
  end
end
