module StorageMethods
  class Blob < ApplicationRecord
    self.table_name = 'storage_methods_blobs'

    def upload(content)
      self.content = content.tempfile.read
      save
      id.to_s
    end

    def download(key)
      return nil if !content_stored?(key)

      reload_by_key(key)
      file = Tempfile.new
      file << content
      file
    end

    def destroy_content(key)
      return nil if !content_stored?(key)

      reload_by_key(key)
      destroy
    end

    def content_stored?(key)
      return StorageMethods::Blob.exists?(key.to_i)
    end

    private
      def reload_by_key(key)
        return if persisted? && id == key.to_i

        self.id = key.to_i
        reload
      end
  end
end
