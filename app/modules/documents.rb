module Documents
  class << self
    def create!(params)
      ActiveRecord::Base.transaction do
        document = Document.new do |doc|
          doc.file  = params.dig(:file)
          doc.name  = doc.file.dig(:original_filename)
          doc.ext   = File.extname(doc.name)
          doc.size  = doc.file.dig(:size)
          doc.path  = params.dig(:path)
          doc.directory_id = params.dig(:directory_id)
        end
        Folder::update_size!(directory: document.directory, addon: document.size)
        document.save!
      end
    rescue => e
      raise e
    end

    def delete(params)
      ActiveRecord::Base.transaction do
        document = Document.find(params.dig(:id))
        Folder::update_size!(directory: document.directory, addon: -document.size)
        document.destroy!
        document
      end
    rescue => e
      raise e
    end
  end
end