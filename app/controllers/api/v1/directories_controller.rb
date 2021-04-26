class Api::V1::DirectoriesController < ApplicationController
  before_action :set_directory, only: %i[show update destroy]

  def index
    @directories = Directory.all.where(directory_id: nil)
  end

  def create
    respond_to do |format|
      @directory = Directory.create(directory_params)

      if @directory.save
        format.json { render 'api/v1/directories/create/success' }
      else
        format.json { render 'api/v1/directories/create/failure', status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def update
    respond_to do |format|
      if @directory.update(directory_params)
        format.json { render 'api/v1/directories/update/success' }
      else
        format.json { render 'api/v1/directories/update/failure', status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @directory.destroy!
    head :no_content
  end

  private

  def set_directory
    begin
      @directory = Directory.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Directory not found', status: 204 }
    end
  end

  def directory_params
    params.permit(:name, :directory_id)
  end
end
