module Api
  module V1
    class DirectoriesController < ApplicationController
      before_action :set_directory, except: %i[index create]

      def index
        @directories = Directory.order(id: :asc, name: :asc)
        render json: DirectorySerializer.new(@directories, is_collection: true)
      end

      def create
        @directory = Directory.create(directory_params)
        if @directory.persisted?
          render json: DirectorySerializer.new(@directory), status: :created
        else
          render json: { errors: @directory.errors }, status: :unprocessable_entity
        end
      end

      def update
        if @directory.update(directory_params)
          render json: DirectorySerializer.new(@directory).serializable_hash
        else
          render json: { errors: @directory.errors }, status: :unprocessable_entity
        end
      end

      def destroy
        @directory.destroy
        render json: @directory, serializer: DirectorySerializer
      end

      private
        def directory_params
          params.require(:directory).permit(:name, :parent_id, files: [])
        end

        def set_directory
          @directory = Directory.find(params[:id])
        end
    end
  end
end
