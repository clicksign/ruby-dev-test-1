module StorageMethods
  class Disk
    def upload(content)
      key = SecureRandom.uuid
      FileUtils.mv(content, storage_path(key))
      key
    end

    def download(key)
      return nil if !content_stored?(key)

      File.open(storage_path(key))
    end

    def destroy_content(key)
      return nil if !content_stored?(key)

      File.delete(storage_path(key))
    end

    def content_stored?(key)
      return File.file?(storage_path(key))
    end

    private
      def storage_path(file_name)
        @storage_path ||= ENV.fetch('DISK_STORAGE_PATH') { 'data' }.chomp('/')
        [@storage_path, file_name].join('/')
      end
  end
end
