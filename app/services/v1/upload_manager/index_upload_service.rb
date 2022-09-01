module V1
  module UploadManager
    class IndexUploadService
      def initialize(*args, folder_id)
        @params = args[0]    
        @folder_id = folder_id    
      end

      def call        
        Folder.find(@folder_id).uploads.includes(:folder, file_attachment: :blob).ransack(@params).result
      end
    end
  end
end