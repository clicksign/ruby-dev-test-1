# frozen_string_literal: true

class FolderSerializer < Blueprinter::Base
  fields :id,
         :name,
         :folder_id
end
