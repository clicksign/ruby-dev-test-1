# frozen_string_literal: true

class FolderSerializer < Blueprinter::Base
  fields :id,
         :name,
         :folder_id

  field :childrens do |folder, _options|
    folder.childrens.present? ? FolderSerializer.render_as_hash(folder.childrens) : []
  end

  field :file_items do |folder, _options|
    folder.file_items.present? ? FileItemSerializer.render_as_hash(folder.file_items) : []
  end
end
