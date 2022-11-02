# frozen_string_literal: true

class FileObject < ApplicationRecord
  validates :name, :path, presence: true
  belongs_to :directory
end
