# frozen_string_literal: true

class FileItemSerializer < Blueprinter::Base
  fields :id,
         :name,
         :folder_id,
         :content
end
