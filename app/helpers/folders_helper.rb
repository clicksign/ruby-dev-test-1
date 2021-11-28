module FoldersHelper
  def back_folder_path(current_folder)
    current_folder.parent_id and current_folder.parent.parent_id ? 
      folder_path(current_folder.parent_id) : 
      folders_path
  end
end
