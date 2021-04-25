class Api::V1::DirectoriesController < ApplicationController
  def index
    @directories = Directory.all.where(directory_id: nil)
  end

  def create
    respond_to do |format|
      @directory = Directory.create(directory_params)

      if @directory.save
        format.json { render 'api/v1/directories/create' } 
      else
        render json: @directory.errors.full_messages, status: :unprocessable_entity
      end
    end
  end

  private

  def directory_params
    params.permit(:name, :directory_id)
  end
end
