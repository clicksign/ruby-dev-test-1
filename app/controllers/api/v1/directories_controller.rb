class Api::V1::DirectoriesController < ApplicationController
  before_action :set_directory, only: %i[show update]

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
    @directory.update(directory_params)
  end

  private

  def set_directory
    respond_to do |format|
      begin
        @directory = Directory.find(params[:id])
        return
      rescue ActiveRecord::RecordNotFound
        format.json { render 'api/v1/directories/show_failure', status: :not_found }
      end
    end
  end

  def directory_params
    params.permit(:name, :directory_id)
  end
end
