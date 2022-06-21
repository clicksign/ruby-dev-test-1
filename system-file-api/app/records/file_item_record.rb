# frozen_string_literal: true

class FileItemRecord < ApplicationRecord
  self.table_name = 'file_items'

  belongs_to :folder, class_name: 'FolderRecord'

  has_one_attached :content
end
