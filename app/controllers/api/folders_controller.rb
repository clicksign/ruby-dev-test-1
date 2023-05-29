# frozen_string_literal: true

module Api
  class FoldersController < Api::ApiController
    def create
      @folder = FolderService.new(params.permit(:path)).create
    end

    def index
      if params[:path].present?
        @folders = Folder.where('path LIKE ?', "#{params[:path]}%")
      elsif params[:name].present?
        @folders = Folder.where(name: params[:name])
      end
    end

    def show
      @folder = Folder.find(params[:id])
    end
  end
end
