# frozen_string_literal: true

class FileItem < Upgrow::Model
  attribute :name
  attribute :folder_id
  attribute :content, required: false
end
