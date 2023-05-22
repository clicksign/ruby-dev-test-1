class Api::V1::ArchivesController < Api::V1::ApiController
  before_action :set_archive, only: [:show, :update, :destroy]

  # POST /api/v1/archives
  def create
    @archive = Archive.new(product_params)

    if @archive.save
      render json: @archive, status: :created
    else
      render json: @archive.errors, status: :unprocessable_entity
    end
  end

  # GET /api/v1/archives/:id
  def show
    if @archive
      render json: @archive, status: :ok
    else
      render json: [], status: :unprocessable_entity
    end
  end

  # PATCH /api/v1/archives/:id
  def update
    if @archive.update(archive_params)
      render json: @archive, status: :ok
    else
      render json: @archive.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/archives/:id
  def destroy
    if @archive.destroy
      render json: @archive, status: :ok
    else
      render json: @archive.errors, status: :unprocessable_entity
    end
  end

  private

  def set_archive
    @archive = Archive.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def archive_params
    params.permit(:name, :id, :folder_id)
  end
end
