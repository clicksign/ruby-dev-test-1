# frozen_string_literal: true

class FileItemUpdateInput < Upgrow::Input
  attribute :name
  attribute :folder_id
  attribute :content

  validates :name, presence: true
  validates :folder_id, presence: true
end
