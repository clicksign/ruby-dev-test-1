# frozen_string_literal: true

class Folder < Upgrow::Model
  attribute :name
  attribute :folder_id, required: false
end
