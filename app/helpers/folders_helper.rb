# frozen_string_literal: true

# FoldersHelper
module FoldersHelper
  def link_to_parent_folder(folder)
    folder.parent_folder.present? ? folder_path(folder.parent_folder) : folders_path
  end
end
