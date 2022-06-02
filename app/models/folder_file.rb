# frozen_string_literal: true

class FolderFile < ApplicationRecord
  belongs_to :folder, optional: true

  scope :roots, -> { where(folder_id: nil) }
end
