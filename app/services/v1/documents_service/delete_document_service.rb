# frozen_string_literal: true

module V1
  module DocumentsService
    class DeleteDocumentService
      def initialize(document_id)
        @document_id = document_id
      end

      def call
        Document.find(@document_id).destroy
      end
    end
  end
end
