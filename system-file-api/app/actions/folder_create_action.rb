# frozen_string_literal: true

class FolderCreateAction < Upgrow::Action
  result :folder

  def perform(params)
    input = FolderInput.new(params)

    if input.valid?
      folder = FolderRepository.create(input)
      result.success(folder: folder)
    else
      result.failure(input.errors)
    end
  end
end
