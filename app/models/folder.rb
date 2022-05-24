# frozen_string_literal: true

class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', foreign_key: :parent_id, optional: true
  has_many :children, class_name: 'Folder', foreign_key: :parent_id, dependent: :destroy

  has_many_attached :files

  validates :name, presence: true, uniqueness: { scope: :parent_id }

  def self.from_root
    Folder.where(parent: nil)
  end

  def path
    "#{parent&.path}/#{name}"
  end

  def is_empty?
    children.empty? && !files.attached?
  end
end
