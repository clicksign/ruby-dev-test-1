module FoldersHelper
  def back_folder_path(current_folder)

    current_folder.parent_id ? 
      folder_path(current_folder.parent_id) : 
      folders_path
  end
end
