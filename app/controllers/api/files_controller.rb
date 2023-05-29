# frozen_string_literal: true

module Api
  class FilesController < Api::ApiController
    def create
      @file = FileService.new(params.permit(:type, :path, :data)).create
    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end

    def index
      return unless params[:name].present?

      @files = FileService.new(params.permit(:name)).list_by_name
    end

    def show
      @file = Storage.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'File not found' }, status: :not_found
    end
  end
end
