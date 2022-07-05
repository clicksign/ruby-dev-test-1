# frozen_string_literal: true

class FolderListParentsAction < Upgrow::Action
  result :folders

  def perform
    folders = FolderRepository.list_parent_folders

    result.success(folders: folders)
  end
end
