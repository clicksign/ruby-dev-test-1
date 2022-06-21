# frozen_string_literal: true

class Folder < Upgrow::Model
  attribute :name
  attribute :childrens, required: false
  attribute :file_items, required: false
  attribute :folder_id, required: false
end
