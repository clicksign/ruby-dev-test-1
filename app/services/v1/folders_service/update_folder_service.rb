# frozen_string_literal: true

module V1
  module FoldersService
    class UpdateFolderService
      def initialize(folder, opts)
        @folder = folder
        @opts = opts
      end

      def call
        @folder.update(@opts)
        @folder
      end
    end
  end
end
