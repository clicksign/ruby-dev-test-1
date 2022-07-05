# frozen_string_literal: true

class FileItemDeleteAction < Upgrow::Action
  def perform(id)
    file_item = FileItemRepository.find(id)
    FileItemRepository.delete(file_item.id)

    result.success
  end
end
