# frozen_string_literal: true

class FileItemUpdateAction < Upgrow::Action
  result :file_item

  def perform(id, folder_id, params)
    input = FileItemUpdateInput.new(params.merge(folder_id: folder_id))

    if input.valid?
      file_item = FileItemRepository.update(id, input)
      result.success(file_item: file_item)
    else
      result.failure(input.errors)
    end
  end
end
