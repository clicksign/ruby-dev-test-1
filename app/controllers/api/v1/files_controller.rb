module Api
  module V1
    class FilesController < ApplicationController
      before_action :set_directory

      def index
        render json: FileSerializer.new(@directory.files, is_collection: true).serializable_hash
      end

      def create
        if @directory.files.attach(files_params[:file])
          render json: FileSerializer.new(@directory.files.last).serializable_hash, status: :created
        else
          head status: :unprocessable_entity
        end
      end

      def destroy
        @file = @directory.files.find(params[:id])
        @file.destroy
        render json: FileSerializer.new(@file)
      end

      private
        def files_params
          params.permit(file: [])
        end

        def set_directory
          @directory = Directory.find(params[:directory_id])
        end
    end
  end
end
