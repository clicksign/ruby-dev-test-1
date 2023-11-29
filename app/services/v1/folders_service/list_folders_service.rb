# frozen_string_literal: true

module V1
  module FoldersService
    class ListFoldersService
      def initialize(opts = {})
        @opts = opts
      end

      def call
        Folder.includes(:parent, :child_folders).page(@opts[:page]).per(@opts[:per_page] || 25)
      end
    end
  end
end
