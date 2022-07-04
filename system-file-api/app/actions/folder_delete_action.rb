# frozen_string_literal: true

class FolderDeleteAction < Upgrow::Action
  def perform(id)
    folder = FolderRepository.find(id)
    FolderRepository.delete(folder.id)

    result.success
  end
end
