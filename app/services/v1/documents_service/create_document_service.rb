# frozen_string_literal: true

module V1
  module DocumentsService
    class CreateDocumentService
      def initialize(folder_id, opts)
        opts[:folder_id] = folder_id
        @document = opts
      end

      def call
        Document.create(@document)
      end
    end
  end
end
