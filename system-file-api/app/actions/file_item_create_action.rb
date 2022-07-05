# frozen_string_literal: true

class FileItemCreateAction < Upgrow::Action
  result :file_item

  def perform(folder_id, params)
    input = FileItemInput.new(params.merge(folder_id: folder_id))

    if input.valid?
      file_item = FileItemRepository.create(input)
      result.success(file_item: file_item)
    else
      result.failure(input.errors)
    end
  end
end
