# frozen_string_literal: true

class Directory < ApplicationRecord
  has_many :file_items, dependent: :destroy
  belongs_to :parent, class_name: 'Directory', optional: true
  has_many :subdirectories, class_name: 'Directory',
                            foreign_key: 'parent_id', dependent: :destroy

  has_one_attached :content
  accepts_nested_attributes_for :subdirectories, reject_if: :all_blank
  accepts_nested_attributes_for :file_items, reject_if: :all_blank
  validates :name, presence: true
end
