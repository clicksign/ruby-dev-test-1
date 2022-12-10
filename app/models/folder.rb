# frozen_string_literal: true

class Folder < ApplicationRecord
  belongs_to :parent, class_name: "Folder", optional: true
  has_many :children, class_name: "Folder", foreign_key: "parent_id", dependent: :destroy, inverse_of: :parent

  has_many_attached :documents, dependent: :destroy

  validates :name, presence: true
  validates :parent, presence: true, if: :parent?

  private

  def parent?
    parent.present?
  end
end
