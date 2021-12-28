# frozen_string_literal: true

class RepositoriesController < ApplicationController
  before_action :set_repository, only: %i[show destroy update]

  def index
    repositories = query
    render json: repositories
  end

  def show
    render json: @repository
  end

  def create
    @repository = Repository.new crud_repository_params
    if @repository.save
      render json: @repository
    else
      render json: @repository.errors.messages, status: :bad_request
    end
  end

  def update
    if @repository.update(crud_repository_params)
      render json: @repository
    else
      render json: @repository.errors.messages, status: :bad_request
    end
  end

  def destroy
    if @repository.destroy
      render nothing: true
    else
      render nothing: true, status: :bad_request
    end
  end

  private

  def query
    Repository.by_type(params[:type]).includes(:origin)
  end

  def set_repository
    @repository = Repository.find(params[:id])
  end

  def repository_params
    %i[id type name origin_id]
  end

  def crud_repository_params
    params.require(:repository).permit(repository_params)
  end
end
