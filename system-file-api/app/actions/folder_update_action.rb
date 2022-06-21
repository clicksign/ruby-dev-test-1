# frozen_string_literal: true

class FolderUpdateAction < Upgrow::Action
  include Shared::FolderValidation
  result :folder

  def perform(id, params)
    folder = FolderRepository.find(id)
    input = FolderInput.new(params)

    if input.valid?
      return result.failure('Parent folder not exists') if folder_parent_valid?(input)

      folder_updated = FolderRepository.update(folder.id, input)
      result.success(folder: folder_updated)
    else
      result.failure(input.errors)
    end
  end
end
