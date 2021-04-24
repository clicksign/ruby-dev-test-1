class Api::V1::DirectoriesController < ApplicationController
  def index
    @directories = Directory.all
  end

  private

  def directory_params
    params.permit(:name)
  end
end