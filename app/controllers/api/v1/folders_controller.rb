class Api::V1::FoldersController < Api::V1::ApiController
  before_action :set_folder, only: [:show, :update, :destroy]

  # POST /api/v1/folders
  def create
    @folder = Folder.new(product_params)

    if @folder.save
      render json: @folder, status: :created
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/folders/:id
  def show
    if @folder
      render json: @folder, status: :ok
    else
      render json: [], status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/folders/:id
  def update
    if @folder.update(folder_params)
      render json: @folder, status: :ok
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/folders/:id
  def destroy
    if @folder.destroy
      render json: @folder, status: :ok
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def folder_params
    params.permit(:name, :id, :parent_id)
  end
end
