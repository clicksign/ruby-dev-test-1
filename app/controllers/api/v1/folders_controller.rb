class Api::V1::FoldersController < ApplicationController
    protect_from_forgery with: :null_session # Remove erro de autenticação    
    before_action :set_folder, except: [:index, :create]

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

    def upload_file
        @folder.files.attach(file_upload_params[:files])
    end

    private

    def folder_params
        params.permit(:name, :parent_folder_id)
    end

    def set_folder
        @folder = Folder.find(params[:id] || params[:folder_id])
    end

    def file_upload_params
        params.permit(files: [])
    end

end
