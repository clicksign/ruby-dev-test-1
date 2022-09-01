module V1
  module FolderManager
    class IndexFolderService
      def initialize(*args)
        @params = args[0]        
      end

      def call
        Folder.includes(:parent, :sub_folders, uploads: [file_attachment: :blob]).ransack(@params).result
      end
    end
  end
end