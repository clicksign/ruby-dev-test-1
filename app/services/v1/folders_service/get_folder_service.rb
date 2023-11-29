# frozen_string_literal: true

module V1
  module FoldersService
    class GetFolderService
      def initialize(folder_id)
        @folder_id = folder_id.to_i
      end

      def call
        Folder.find(@folder_id)
      end
    end
  end
end
