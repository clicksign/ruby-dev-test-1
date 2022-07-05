# frozen_string_literal: true

class FileItemRepository
  class << self
    def all
      FileItemRecord.all.map do |record|
        to_file_item_model(record.attributes)
      end
    end

    def create(input)
      record = FileItemRecord.create!(input.to_hash)
      to_file_item_model(record.attributes)
    end

    def find(id)
      record = FileItemRecord.find(id)
      to_file_item_model(record.attributes)
    end

    def list_by_folder(folder_id)
      records = FileItemRecord.where(folder_id: folder_id).order(:name)
      records.map do |item|
        to_file_item_model(item.attributes)
      end
    end

    def update(id, input)
      record = FileItemRecord.find(id)
      record.update!(input)
      to_file_item_model(record.attributes)
    end

    def delete(id)
      record = FileItemRecord.find(id)
      record.destroy!
    end

    def to_file_item_model(attributes)
      FileItem.new(**attributes.symbolize_keys)
    end
  end
end
