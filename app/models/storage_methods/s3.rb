module StorageMethods
  class S3
    def upload(content)
      key = SecureRandom.uuid
      resp = client.put_object({
        body: content,
        bucket: ENV.fetch('S3_STORAGE_BUCKET'),
        key: key
      })
      return nil if !resp.successful?

      key
    end

    def download(key)
      return nil if !content_stored?(key)

      resp = client.get_object({
        bucket: ENV.fetch('S3_STORAGE_BUCKET'),
        key: key
      })
      return nil if !resp.successful?

      file = Tempfile.new
      file << resp.body.read
      file
    end

    def destroy_content(key)
      return nil if !content_stored?(key)

      resp = client.delete_object({
        bucket: ENV.fetch('S3_STORAGE_BUCKET'),
        key: key
      })
      resp.successful?
    end

    def content_stored?(key)
      begin
        resp = client.get_object_attributes({
          bucket: ENV.fetch('S3_STORAGE_BUCKET'),
          key: key,
          object_attributes: ["ObjectSize"]
        })
        resp.successful? && resp.object_size > 0
      rescue Aws::S3::Errors::NoSuchKey
        false
      end
    end

    private
      def client
        @client ||= Aws::S3::Client.new(region: ENV.fetch('AWS_REGION'))
      end
  end
end
