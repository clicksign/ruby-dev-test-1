# frozen_string_literal: true

class FolderCreateAction < Upgrow::Action
  result :folder

  def perform(params)
    input = FolderCreateInput.new(params)

    if input.valid?
      if !input.folder_id.nil? && !FolderRepository.exists(input.folder_id)
        return result.failure('Parent folder not exists')
      end

      folder = FolderRepository.create(input)
      result.success(folder: folder)
    else
      result.failure(input.errors)
    end
  end
end
