# frozen_string_literal: true

class Document < ApplicationRecord
  belongs_to :directory, class_name: 'Directory'
  has_one_attached :content

  validates :name, :content, :directory, presence: true
  validates_uniqueness_of :name, scope: :directory_id
end
