# frozen_string_literal: true

module V1
  module FoldersService
    class DeleteFolderService
      def initialize(folder_id)
        @folder_id = folder_id
      end

      def call
        Folder.find(@folder_id).destroy
      end
    end
  end
end
