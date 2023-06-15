module Api
  module V1
    class DirectoriesController < ApplicationController
      def create
        render json: Directories::CreateService.call(directory_params)
      end

      def update
        render json: Directories::UpdateService.call(directory_params)
      end

      private

      def directory_params
        @directory_params ||= params.permit(:id, :name, :parent_id)
      end
    end
  end
end
