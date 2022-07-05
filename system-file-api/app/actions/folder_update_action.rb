# frozen_string_literal: true

class FolderUpdateAction < Upgrow::Action
  result :folder

  def perform(id, params)
    folder = FolderRepository.find(id)
    input = FolderInput.new(params)

    if input.valid?
      folder_updated = FolderRepository.update(folder.id, input)
      result.success(folder: folder_updated)
    else
      result.failure(input.errors)
    end
  end
end
