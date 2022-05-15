# frozen_string_literal: true

class Directory < ApplicationRecord
  belongs_to :parent, optional: true, class_name: 'Directory'

  has_many :subdirectories, dependent: :destroy,
                            class_name: 'Directory', foreign_key: 'parent_id'

  has_many_attached :files

  validates :title, presence: true
  validates_uniqueness_of :title, scope: :parent_id
end
