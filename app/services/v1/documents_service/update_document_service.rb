# frozen_string_literal: true

module V1
  module DocumentsService
    class UpdateDocumentService
      def initialize(document, opts)
        @document = document
        @opts = opts
      end

      def call
        @document.update(@opts)
        @document
      end
    end
  end
end
