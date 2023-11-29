# frozen_string_literal: true

module V1
  class FoldersController < ApplicationController
    before_action :set_folder, only: %i[update show destroy]

    def index
      render json: FoldersService::ListFoldersService.new(paginate_params).call
    end

    def create
      folder = FoldersService::CreateFolderService.new(folder_params).call
      return render json: { errors: folder.errors }, status: :unprocessable_entity if folder.errors.any?

      render json: folder, status: :created
    end

    def update
      folder = FoldersService::UpdateFolderService.new(@folder, folder_params).call
      return render json: { errors: folder.errors }, status: :unprocessable_entity if folder.errors.any?

      render json: { folder:, message: 'Folder updated successfully' }, status: :ok
    end

    def show
      return render json: @folder, status: :ok if @folder.present?

      render json: { errors: ['Folder not found'] }, status: :not_found
    end

    def destroy
      unless FoldersService::DeleteFolderService.new(@folder.id).call
        return render json: { errors: [e.message] }, status: :unprocessable_entity
      end

      render json: { message: 'Folder deleted successfully' }, status: :ok
    end

    private

    def folder_params
      params.require(:folder).permit(:name, :parent_id)
    end

    def set_folder
      if params[:folder_id].blank?
        return render json: { errors: ['Folder_id is required'] }, status: :unprocessable_entity
      end

      @folder = FoldersService::GetFolderService.new(params[:folder_id]).call
    end
  end
end
