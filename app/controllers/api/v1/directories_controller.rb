# frozen_string_literal: true

module Api
  module V1
    class DirectoriesController < ApplicationController
      before_action :set_directory, only: %i[show edit update destroy upload_file]

      def index
        @directories = Directory.all

        render json: @directories
      end

      def show
        render json: @directory
      end

      def upload_file
        @directory.files.attach(params[:files])
      end

      def create
        @directory = Directory.new(directory_params)

        if @directory.save
          render json: @directory
        else
          render json: @directory.errors, status: :unprocessable_entity
        end
      end

      def update
        if @directory.update(directory_params)
          render json: @directory
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
        params.require(:directory).permit(:title, :parent_id, files: [])
      end
    end
  end
end
