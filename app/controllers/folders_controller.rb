class FoldersController < ApplicationController
  before_action :set_folder, only: %i[update destroy]
  def create
    @folder = Folder.new(folder_params)
    if @folder.save
      render json: @folder, status: :created
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  def index
    @folders = Folder
               .includes(:children)
               .root_level
               .order(name: :asc)
               .with_attached_files
               .all
    render json: @folders
  end

  def show
    @folder = Folder
              .includes(:children)
              .with_attached_files
              .find(params[:id])

    render json: @folder
  end

  def destroy
    @folder.destroy
  end

  def update
    if @folder.update(folder_params)
      render json: @folder, status: :ok
    else
      render json: @folder.errors, status: :unprocessable_entity
    end
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :parent_id)
  end
end
