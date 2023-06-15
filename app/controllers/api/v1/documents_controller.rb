module Api
  module V1
    class DocumentsController < ApplicationController
      def create
        render json: Documents::CreateService.call(document_params)
      end
      
      def update
        render json: Documents::UpdateService.call(document_params)
      end

      def destroy
        render json: Documents::DestroyService.call(document_params)
      end

      private

      def document_params
        @document_params ||= params.permit(:name, :directory_id, :file, :provider)
      end
    end
  end
end
