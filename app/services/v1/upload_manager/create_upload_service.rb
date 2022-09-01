module V1
  module UploadManager
    class CreateUploadService
      def initialize(*args)
        @upload = args[0]
      end

      def call
        Upload.create(folder_id: @upload[:folder_id], file: signature_decoded)
      end

      private

      def signature_decoded
        decoded_data = Base64.decode64(@upload[:file].split(',')[1])
        {
          io:           StringIO.new(decoded_data),
          content_type: 'image/jpeg',
          filename:     "upload-#{Time.current.to_i}.jpg"
        }
      end
    end
  end
end