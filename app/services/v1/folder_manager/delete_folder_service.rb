module V1
  module FolderManager
    class DeleteFolderService
      def initialize(*args)
        @folder = args[0]
      end
  
      def call        
        @folder.destroy        
      end
    end
  end
end