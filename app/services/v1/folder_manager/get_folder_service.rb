module V1
  module FolderManager
    class GetFolderService
      def initialize(id)
        @id = id
      end

      def call
        Folder.find(@id)
      end
    end
  end
end