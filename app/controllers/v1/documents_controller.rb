# frozen_string_literal: true

module V1
  class DocumentsController < ApplicationController
    before_action :set_document, only: %i[update show destroy]

    def index
      render json: DocumentsService::ListDocumentsService.new(paginate_params).call
    end

    def create
      document = DocumentsService::CreateDocumentService.new(params[:folder_id], document_params).call
      return render json: { errors: document.errors }, status: :unprocessable_entity if document.errors.any?

      render json: document, status: :created
    end

    def update
      document = DocumentsService::UpdateDocumentService.new(@document, document_params).call
      return render json: { errors: document.errors }, status: :unprocessable_entity if document.errors.any?

      render json: { document:, message: 'Document updated successfully' }, status: :ok
    end

    def show
      return render json: @document, status: :ok if @document.present?

      render json: { errors: ['Document not found'] }, status: :not_found
    end

    def destroy
      unless DocumentsService::DeleteDocumentService.new(@document.id).call
        return render json: { errors: [e.message] }, status: :unprocessable_entity
      end

      render json: { message: 'Document deleted successfully' }, status: :ok
    end

    private

    def document_params
      params.require(:document).permit(:name, :file)
    end

    def set_document
      if params[:document_id].blank?
        return render json: { errors: ['Document_id is required'] }, status: :unprocessable_entity
      end

      @document = DocumentsService::GetDocumentService.new(params[:document_id]).call
    end
  end
end
