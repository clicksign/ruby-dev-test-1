# frozen_string_literal: true

class FileItem < ApplicationRecord
  belongs_to :folder

  has_one_attached :content
end
