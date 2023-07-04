# frozen_string_literal: true

class FileItem < ApplicationRecord
  belongs_to :directory
  has_one_attached :content
end
