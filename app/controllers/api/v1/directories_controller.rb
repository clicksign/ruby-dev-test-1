module Api
  module V1
    class DirectoriesController < ApplicationController
      before_action :set_directory, only: %i[update destroy]

      def index
        @directories = Directory.arrange_serializable
      end

      def create
        @directory = Directory.new(directory_params)
        if @directory.save
          response.status = 201
        else
          response.status = 422
        end
      end

      def update
        response.status = 422 unless @directory.update(directory_params)
      end

      def destroy
        @directory.destroy
      end

      private
        def directory_params
          params.require(:directory).permit(:name, :parent_id)
        end

        def set_directory
          @directory = Directory.find(params[:id])
        end
    end
  end
end
