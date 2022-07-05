# frozen_string_literal: true

class FileItemRepository
  class << self
    def all
      FileItemRecord.all.map do |record|
        to_file_item_model(record.attributes, record.content)
      end
    end

    def create(input)
      record = FileItemRecord.new(input.to_hash)
      record.content.attach(input.content)
      record.save!

      to_file_item_model(record.attributes, record.content)
    end

    def find(id)
      record = FileItemRecord.find(id)
      to_file_item_model(record.attributes, record.content)
    end

    def list_by_folder(folder_id)
      records = FileItemRecord.where(folder_id: folder_id).order(:name)
      records.map do |item|
        to_file_item_model(item.attributes, item.content)
      end
    end

    def update(id, input)
      record = FileItemRecord.find(id)
      if input.content
        record.content.purge
        record.content.attach(input.content)
      end

      record.update!(input.to_hash)

      to_file_item_model(record.attributes, record.content)
    end

    def delete(id)
      record = FileItemRecord.find(id)
      record.destroy!
    end

    def to_file_item_model(attributes, content)
      FileItem.new(**attributes.merge(content: content.key).symbolize_keys)
    end
  end
end
