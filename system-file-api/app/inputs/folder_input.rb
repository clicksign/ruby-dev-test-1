# frozen_string_literal: true

class FolderInput < Upgrow::Input
  attribute :name
  attribute :folder_id

  validates :name, presence: true
end
