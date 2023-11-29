# frozen_string_literal: true

module V1
  module DocumentsService
    class ListDocumentsService
      def initialize(opts = {})
        @opts = opts
      end

      def call
        Document.page(@opts[:page]).per(@opts[:per_page])
      end
    end
  end
end
