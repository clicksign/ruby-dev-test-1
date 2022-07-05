# frozen_string_literal: true

class FileItem < Upgrow::Model
  attribute :name
  attribute :content, required: false
end
