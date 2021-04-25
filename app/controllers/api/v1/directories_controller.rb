class Api::V1::DirectoriesController < ApplicationController
  before_action :set_directory, only: %i[show]

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

  private

  def set_directory
    @directory = Directory.find(params[:id])
  end

  def directory_params
    params.permit(:name, :directory_id)
  end
end
