module V1
  class UploadsController < ApplicationController
    before_action :set_upload, only: %i[ show update destroy]

    # GET /@uploads
    def index      
      @uploads = UploadManager::IndexUploadService.new(params[:q], params[:folder_id]).call
      render json: @uploads.page(params[:page])
    end

    # GET /@uploads/1
    def show
      render json: @upload
    end

    # POST /@uploads
    def create
      @upload = UploadManager::CreateUploadService.new(upload_params).call
      if @upload.errors.any?
        render json: ErrorSerializer.serialize(@upload.errors), status: :unprocessable_entity
      else
        render json: @upload, status: :created
      end
    end

    # PATCH/PUT /@uploads/1
    def update
      @upload = UploadManager::UpdateUploadService.new(@upload, upload_params).call
      if @upload.errors.any?
        render json: ErrorSerializer.serialize(@upload.errors), status: :unprocessable_entity
      else
        render json: @upload
      end      
    end

    # DELETE /@uploads/1
    def destroy
      UploadManager::DeleteUploadService.new(@upload).call
    end
   
    private
    
    # Use callbacks to share common setup or constraints between actions.
    
    def set_upload      
      begin
        id = params[:id].presence || params[:upload_id]
        @upload = UploadManager::GetUploadService.new(id).call
      rescue Exception => e
        render json: {error: e.message}, status: :not_found
      end
    end

    def upload_params      
      ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:file, :folder_id])
    end
  end    
end