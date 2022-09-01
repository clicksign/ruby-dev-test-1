module V1
  module FolderManager
    class CreateFolderService
      def initialize(*args)
        @folder = args[0]        
      end

      def call
        Folder.create(@folder)
      end
    end
  end
end