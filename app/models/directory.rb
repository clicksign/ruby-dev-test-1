# frozen_string_literal: true

class Directory < ApplicationRecord
  has_many :subdirectories, class_name: 'Directory', foreign_key: 'parent_id', dependent: :destroy
  belongs_to :parent, class_name: 'Directory', optional: true
  has_many :archives, dependent: :destroy

  validates :name, presence: true
  validates_uniqueness_of :name, scope: :parent_id
end
