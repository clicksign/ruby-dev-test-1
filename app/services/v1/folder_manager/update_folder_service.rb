module V1
  module FolderManager
    class UpdateFolderService
      def initialize(*args, params)
        @folder = args[0]
        @params = params
      end

      def call
        @folder.update(@params)      
        @folder
      end
    end
  end
end