module Api
  module V1
    class FilesController < ApplicationController
      before_action :set_directory

      def index; end

      def create
        if @directory.files.attach(files_params[:file])
          response.status = 201
        else
          response.status = 500
        end
      end

      def destroy
        @file = @directory.files.find(params[:id])
        @file.destroy
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
