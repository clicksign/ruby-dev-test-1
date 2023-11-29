# frozen_string_literal: true

module V1
  module FoldersService
    class CreateFolderService
      def initialize(opts)
        @folder = opts
      end

      def call
        Folder.create(@folder)
      end
    end
  end
end
