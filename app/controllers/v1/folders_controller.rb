module V1
  class FoldersController < ApplicationController  
    include JSONAPI::Deserialization
    include JSONAPI::Pagination    
        
    before_action :set_folder, only: %i[ show update destroy ]

    # GET /folders
    def index
      folders = Folder.ransack(params[:q]).includes(:parent, :sub_folders, :uploads).all
      render json: folders
    end

    # GET /folders/1
    def show
      render json: FolderSerializer.new(folder).serializable_hash.to_json
    end

    # POST /folders
    def create      
      folder = CreateFolderService.new(folder_params).call      
      if folder.errors.any?
        render json: folder.errors, status: :unprocessable_entity
      else
        render json: FolderSerializer.new(folder).serializable_hash.to_json, status: :created
      end
    end

    # PATCH/PUT /folders/1
    def update
      if folder.update(folder_params)
        render json: folder
      else
        render json: folder.errors, status: :unprocessable_entity
      end
    end

    # DELETE /folders/1
    def destroy
      folder.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
    def set_folder
      folder = Folder.includes(parent, :sub_folders, :uploads).find(params[:id])
    end

    def folder_params
      jsonapi_deserialize(params, only: [:name, :parent_id])
    end
  end    
end