# frozen_string_literal: true

module V1
  module DocumentsService
    class GetDocumentService
      def initialize(document_id)
        @document_id = document_id.to_i
      end

      def call
        Document.find(@document_id)
      end
    end
  end
end
