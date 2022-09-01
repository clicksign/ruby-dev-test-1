module V1
  module UploadManager
    class DeleteUploadService
      def initialize(*args)
        @upload = args[0]        
      end
  
      def call
        @upload.destroy        
      end
    end
  end
end