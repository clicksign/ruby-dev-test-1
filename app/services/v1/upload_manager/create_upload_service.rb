module V1
  module UploadManager
    class CreateUploadService
      def initialize(*args)
        @upload = args[0]
      end

      def call
        Upload.create(folder_id: @upload[:folder_id], file: ensured_file)
      end

      private

      def ensured_file        
        ApplicationManager::GetEnsuredFileParamsService.new(@upload[:file]).call
      end
    end
  end
end