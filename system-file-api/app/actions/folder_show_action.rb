# frozen_string_literal: true

class FolderShowAction < Upgrow::Action
  result :folder

  def perform(id)
    folder = FolderRepository.find_with_childrens_and_files(id)

    result.success(folder: folder)
  end
end
