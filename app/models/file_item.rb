# frozen_string_literal: true

class FileItem < ApplicationRecord
  belongs_to :directory, inverse_of: :file_items
  has_one_attached :content
end
