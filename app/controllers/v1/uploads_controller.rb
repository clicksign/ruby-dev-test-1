module V1
  class UploadsController < ApplicationController
    before_action :set_upload, only: %i[ show update destroy ]

    def index      
      @uploads = UploadManager::IndexUploadService.new(upload_search_params, params[:folder_id]).call
      render json: @uploads.page(params[:page])
    end

    def show
      render json: @upload
    end

    def create
      @upload = UploadManager::CreateUploadService.new(upload_params).call
      if @upload.errors.any?
        render json: ErrorSerializer.serialize(@upload.errors), status: :unprocessable_entity
      else
        render json: @upload, status: :created
      end
    end

    def update
      @upload = UploadManager::UpdateUploadService.new(@upload, upload_params).call
      if @upload.errors.any?
        render json: ErrorSerializer.serialize(@upload.errors), status: :unprocessable_entity
      else
        render json: @upload
      end      
    end

    def destroy
      UploadManager::DeleteUploadService.new(@upload).call
    end
   
    private    
    
    def set_upload      
      begin        
        @upload = UploadManager::GetUploadService.new(params[:id]).call
      rescue Exception => e
        render json: {error: e.message}, status: :not_found
      end
    end

    def upload_params      
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:file, :folder_id])
    end

    def upload_search_params
      params.require(:q).permit(:file_attachment_blob_filename_i_cont) if params[:q]
    end
  end    
end