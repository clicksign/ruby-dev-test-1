class Api::V1::FoldersController < ApplicationController
    before_action :set_folder, only: [:show, :update, :destroy]

    def index
        @folders = Folder.all
        render json: @folders
    end

    def show
        render json: @folder
    end

    def create
        @folder = Folder.new(folder_params)

        unless @folder.save
            render json: @folder.errors, status: :unprocessable_entity
        end

        render json: @folder, status: :created
    end

    def update
        unless @folder.update(folder_params)
            render json: @folder.errors, status: :unprocessable_entity
        end
        render json: @folder
    end

    def destroy
        @folder.destroy
    end

    private

    def folder_params
        params.require(:folder).permit(:name, :parent_folder_id, files: [])
    end

    def set_folder
        @folder = Folder.find(params[:id])
    end

end
