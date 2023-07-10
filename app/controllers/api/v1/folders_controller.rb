module Api
  module V1
    class FoldersController < ApplicationController
      before_action :set_folder, only: %i[show update destroy]

      # GET /folders
      def index
        # TODO: Add Paginate
        @folders = Folder.all

        render json: @folders, methods: [:full_path],
              include: {
                archives: {
                  only: [:id, :status],
                  methods: [:file]
                }
              }
      end

      # GET /folders/1
      def show
        render_folder
      end

      # POST /folders
      def create
        @folder = Folder.new(folder_params)

        if @folder.valid? && @folder.save
          render_folder :created
        else
          render json: @folder.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /folders/1
      def update
        if @folder.update(folder_params)
          render_folder
        else
          render json: @folder.errors, status: :unprocessable_entity
        end
      end

      # DELETE /folders/1
      def destroy
        head :no_content if @folder.destroy
      end

      private

      def set_folder
        @folder = Folder.find_by(id: params[:id])
      end

      def folder_params
        params.require(:folder).permit(:name, sub_folders_attributes: %i[id name],
                                              archives_attributes: %i[id file]).to_h
      end

      def render_folder(status = :ok)
        render json: @folder, status:, methods: [:full_path],
              include: {
                archives: {
                  only: [:id, :status],
                  methods: [:file]
                }
              }
      end
    end
  end
end
