module FoldersHelper
  def link_to_parent_folder(folder)
    if folder.parent_folder.present?
      path = folder_path(folder.parent_folder)
      name = folder.parent_folder.name
    else
      path = folders_path
      name = '...'
    end
    link_to(name, path)
  end

  def link_to_back_folder(folder_id = nil)
    folder_id.present? ? folder_path(folder_id) : folders_path
  end
end
