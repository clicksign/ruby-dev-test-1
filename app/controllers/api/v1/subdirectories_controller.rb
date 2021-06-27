class Api::V1::SubdirectoriesController < ApplicationController
  before_action :set_directory
  before_action :set_subdirectory, only: [:show, :update, :destroy]

  # GET /directories/:directory_id/subdirectories
  def index
    @subdirectories = @directory.subdirectories

    render json: @subdirectories
  end

  # GET /directories/:directory_id/subdirectories/1
  def show
    render json: @subdirectory
  end

  # POST /directories/:directory_id/subdirectories
  def create
    @subdirectory = @directory.subdirectories.build(subdirectory_params)

    if @subdirectory.save
      render json: @subdirectory, status: :created, location: @api_v1_directory_subdirectory
    else
      render json: @subdirectory.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /directories/:directory_id/subdirectories/1
  def update
    if @subdirectory.update(subdirectory_params)
      render json: @subdirectory
    else
      render json: @subdirectory.errors, status: :unprocessable_entity
    end
  end

  # DELETE /directories/:directory_id/subdirectories/1
  def destroy
    @subdirectory.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_directory
      @directory = Directory.find(params[:directory_id])
    end

    def set_subdirectory
      @subdirectory = @directory.subdirectories.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subdirectory_params
      params.require(:subdirectory).permit(:name, archives: [])
    end
end
