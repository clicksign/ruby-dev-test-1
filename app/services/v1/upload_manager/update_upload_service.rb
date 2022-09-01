module V1
  module UploadManager
    class UpdateUploadService
      def initialize(*args, params) 
        @upload = args[0]   
        @params = params        
      end

      def call
        @upload.update(file: signature_decoded)
        @upload
      end

      private

      def signature_decoded
        decoded_data = Base64.decode64(@params[:file].split(',')[1])
        {
          io:           StringIO.new(decoded_data),
          content_type: 'image/jpeg',
          filename:     "upload-#{Time.current.to_i}.jpg"
        }
      end
    end
  end
end