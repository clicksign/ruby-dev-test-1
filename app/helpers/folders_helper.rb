module FoldersHelper
  def folder_icon(folder)
    folder.is_empty? ? "empty-folder.png" : "files-and-folders.png"
  end
end
