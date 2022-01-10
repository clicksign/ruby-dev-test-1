module Api::V1
  class DirectoriesController < ApplicationController
    before_action :load_directory, only: [:show, :update, :destroy]

    def index
      @directories = Directory.all
    end

    def create
      @directory = Directory.new
      @directory.attributes = directory_params
      save_directory!
    end

    def show; end

    def update
      @directory.attributes = directory_params
      save_directory!
    end

    def destroy
      @directory.destroy!
    rescue
      render_error(fields: @directory.errors.messages)
    end

    private

    def load_directory
      @directory = Directory.with_attached_files.includes(:subdirectories).find(params[:id])
    end

    def directory_params
      return {} unless params.has_key?(:directory)
      params.require(:directory).permit(:id, :name, :parent_id, files: [])
    end

    def save_directory!
      @directory.save!
      render :show
    rescue
      render_error(fields: @directory.errors.messages)
    end
  end
end
