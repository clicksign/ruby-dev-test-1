# frozen_string_literal: true

class FolderListChildrensAction < Upgrow::Action
  result :folders

  def perform(id)
    folders = FolderRepository.childrens(id)

    result.success(folders: folders)
  end
end
