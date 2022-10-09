# frozen_string_literal: true

class BucketService
  class << self
    def get_file(key)
      path = temp_destination(key)
      obj = bucket.object(key)
      success = obj.download_file(path)

      raise(StandardError, 'Error to download file') unless success

      path
    end

    def create_file!(file)
      path = define_path(file)
      obj = bucket.object(path)
      success = obj.upload_file(file)

      raise(StandardError, 'Error to upload file') unless success

      path
    end

    def bucket
      Aws::S3::Resource.new.bucket(ENV.fetch('AWS_S3_BUCKET'))
    end

    private

    def define_path(file)
      today = Time.zone.now

      "#{today.year}/#{today.month}/#{today.day}/#{file_name(file)}"
    end

    def temp_destination(key)
      filename = key.split('/').last
      Rails.root.join("storage/#{filename}")
    end

    def file_name(file)
      case file.class.to_s
      when 'ActionDispatch::Http::UploadedFile'
        file.original_filename
      when 'File'
        File.basename(file)
      when 'Pathname'
        file.basename.to_s
      else
        file
      end
    end
  end
end
