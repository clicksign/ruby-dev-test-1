class Api::V1::FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:creae, :update, :destroy]

  # GET /folders
  def index
    @folders = Folder.includes(:parent_folder).all

    render json: @folders
  end

  # GET /folders/1
  def show
    render json: @folder
  end

  # POST /folders
  def create
    @folder = Folder.new(folder_params)

    if @folder.save
      render json: @folder, status: :created, location: @api_v1_folder
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /folders/1
  def update
    if @folder.update(folder_params)
      render json: @folder
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  # DELETE /folders/1
  def destroy
    @folder.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_folder
      @folder = Folder.with_attached_archives.includes(:child_folders).find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def folder_params
      params.require(:folder).permit(:name, :parent_folder_id, archives: [])
    end
end
