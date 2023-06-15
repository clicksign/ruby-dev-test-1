module API
  module V1
    class DirectoriesController < ApplicationController
      def create
        Directories::CreateService.call(**directory_params)
      end

      def update
        Directories::UpdateService.call(**directory_params)
      end

      private

      def directory_params
        @directory_params ||= params.permit(:name, :parent_id)
      end
    end
  end
end
