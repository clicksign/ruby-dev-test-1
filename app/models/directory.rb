# frozen_string_literal: true

class Directory < ApplicationRecord
  belongs_to :parent, class_name: 'Directory', optional: true

  has_many :subdirectories, class_name: 'Directory', foreign_key: 'parent_id', dependent: :destroy, inverse_of: :parent
  has_many :documents, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :parent_id }

  def path
    return "/#{name}" if parent.nil?

    "#{parent.path}/#{name}"
  end

  def size
    size = documents.includes(:content_blob).sum(&:size)

    return size if subdirectories.blank?

    size + subdirectories.sum(&:size)
  end
end
