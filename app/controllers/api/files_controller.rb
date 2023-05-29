# frozen_string_literal: true

module Api
  class FilesController < Api::ApiController
    def create
      begin
        @file = FileService.new(params.permit(:type, :path, :data)).create
      rescue StandardError => e
        render json: { error: e.message }, status: :unprocessable_entity
      end
    end

    def index
      if params[:name].present?
        @files = FileService.new(params.permit(:name)).list_by_name
      end
    end

    def show
      begin
        @file = Storage.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'File not found' }, status: :not_found
      end
    end
  end
end