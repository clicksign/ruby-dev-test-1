module Api
  module V1
    class DirectoriesController < ApplicationController
      before_action :set_directory, only: %i[show update destroy]

      def index
        @directories = Directory.all
      end

      def show; end

      def create
        @directory = Directory.new(directory_params)
        @directory.files.attach(params[:file])

        if @directory.save
          render :show
        else
          render json: @directory.errors
        end
      end

      def update
        if @directory.update(directory_params)
          render :show
        else
          render json: @directory.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @directory.destroy
      end

      private

      def set_directory
        @directory = Directory.find(params[:id])
      end

      def directory_params
        params.require(:directory).permit(:name, :parent_id, files: [])
      end
    end
  end
end
