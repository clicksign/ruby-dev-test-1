module V1
  module UploadManager
    class GetUploadService
      def initialize(id)
        @id = id
      end

      def call
        Upload.includes(file_attachment: :blob).find(@id)
      end
    end
  end
end