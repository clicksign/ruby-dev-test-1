module Directories
  class << self
    def create!(params)
      ActiveRecord::Base.transaction do
        directory = Directory.new do |dir|
          dir.name      = params.dig(:name)
          dir.path      = params.dig(:path)
          dir.parent_id = params.dig(:parent_id)
        end
        directory.save!
      end
    rescue => e
      raise e
    end

    def delete!(params)
      ActiveRecord::Base.transaction do
        directory = Directory.find(params.dig(:id))
        directory.destroy!
      end
    rescue => e
      raise e
    end

    def update_size!(directory:, addon:)
      ActiveRecord::Base.transaction do
        directory.update!(size: directory.size + addon)
      end
    rescue => e
      raise e
    end

    def open(directory_id:)
      ActiveRecord::Base.transaction do
        directory = Directory.find directory_id
        { documents: directory.documents, sub_directories: directory.sub_directories, size: directory.size, parent: directory.parent }
      end
    rescue => e
      raise e
    end
  end
end