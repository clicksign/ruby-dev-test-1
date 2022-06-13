module Api
  module V1
    class FoldersController < ApiController

      before_action :set_folder, only: %i[ show update destroy sub_folders]

      def index
        @folders = Folder.all
      end

      def sub_folders
        @folders = @folder.sub_folders
      end

      def show
      end

      def create
        @folder = Folder.new(folder_params)

        if @folder.save
          render 'show', status: :created, locals: { folder: @folder }
        else
          render json: @folder.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /folders/1 or /folders/1.json
      def update
        if @folder.update(folder_params)
          render :show, status: :ok, locals: {folder: @folder}
        else
          render json: @folder.errors, status: :unprocessable_entity
        end
      end

      # DELETE /folders/1 or /folders/1.json
      def destroy
        @folder.destroy
        head :no_content
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def set_folder
          @folder = Folder.find(params[:id])
        end

        # Only allow a list of trusted parameters through.
        def folder_params
          params.require(:folder).permit(:name, :permission, :parent)
        end
    end
  end
end
