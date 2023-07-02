module Api
  module VersionOne
    class DirectoriesController < ApplicationController

      ATTR_METHODS = %i[id name parent_id created_by_id]

      before_action :authenticate_user!
      before_action :set_directory, 
                    only: %i[show update destroy get_subdirectories archives]

      def index
        render json: { directories: directories_filter.paginate(params[:page], 
                       only: ATTR_METHODS)}
      end

      def create
        directory = Directory.new(directories_params.merge(
          { created_by_id: current_user.id }
        ))

        if directory.save
          render json: { error: false, directory: directory}
        end
      rescue => e
        render json: { error: true, message: e }
      end

      def show
        render json: { directory: @directory }
      end

      def update
        @directory.update(directories_params)
        render json: { directory: @directory }
      rescue => e
        render json: { error: true, message: e }
      end

      def destroy
        @directory.destroy
        render json: { error: false }
      rescue => e
        render json: { error: true, message: e }
      end

      def get_subdirectories
        subdirectories = Directory.subdirectories(@directory.id)
        render json: { directory: @directory, 
                        subdirectories: subdirectories.paginate(params[:page], 
                        only: ATTR_METHODS)}
      end

      private

      def directories_filter
        Directory.all.order(name: :asc)
      end

      def set_directory
        @directory = Directory.find_by(id: params[:id])
      end

      def directories_params
        params.require(:directory).permit(
          :name,
          :parent_id,
        )
      end
    end
  end
end