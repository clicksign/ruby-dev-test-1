module V1
  class FoldersController < ApplicationController        
    before_action :set_folder, only: %i[ show update destroy sub_folders parent ]
  
    def index      
      @folders = FolderManager::IndexFolderService.new(folder_search_params).call
      render json: @folders.page(params[:page])
    end

    def show
      render json: @folder
    end

    def create
      @folder = FolderManager::CreateFolderService.new(folder_params).call
      if @folder.errors.any?
        render json: ErrorSerializer.serialize(@folder.errors), status: :unprocessable_entity
      else
        render json: @folder, status: :created
      end
    end

    def update
      @folder = FolderManager::UpdateFolderService.new(@folder, folder_params).call
      if @folder.errors.any?
        render json: ErrorSerializer.serialize(@folder.errors), status: :unprocessable_entity
      else
        render json: @folder
      end      
    end

    def destroy
      FolderManager::DeleteFolderService.new(@folder).call
    end

    def sub_folders
      render json: @folder.sub_folders
    end

    def parent
      render json: @folder.parent
    end

    private    
    
    def set_folder
      begin
        id = params[:id].presence || params[:folder_id]
        @folder = FolderManager::GetFolderService.new(id).call
      rescue Exception => e
        render json: {error: e.message}, status: :not_found
      end
    end

    def folder_params      
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name, :parent_id])
    end

    def folder_search_params
      params.require(:q).permit(:name_i_cont) if params[:q]
    end
  end    
end