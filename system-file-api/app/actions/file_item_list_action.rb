# frozen_string_literal: true

class FileItemListAction < Upgrow::Action
  result :file_items

  def perform(folder_id)
    file_items = FileItemRepository.list_by_folder(folder_id)

    result.success(file_items: file_items)
  end
end
