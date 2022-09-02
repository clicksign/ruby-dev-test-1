module V1
  module UploadManager
    class UpdateUploadService
      def initialize(*args, params) 
        @upload = args[0]   
        @params = params        
      end

      def call
        @upload.update(file: ensured_file)
        @upload
      end

      private

      def ensured_file
        ApplicationManager::GetEnsuredFileParamsService.new(@params[:file]).call
      end
    end
  end
end