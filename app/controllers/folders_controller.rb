class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :update, :destroy]

  # GET /folders
  def index
    @folders = Folder.all

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
      render json: @folder, status: :created, location: @folder
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
      @folder = Folder.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def folder_params
      params.require(:folder).permit(:name)
    end
end
