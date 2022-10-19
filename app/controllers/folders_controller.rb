class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :update, :destroy]

  def index
    @folders = Folder.includes(:documents, :children).where(parent_id:).paginate(page:)

    render json: @folders, includes: [:documents, :children]
    # This 'includes'are necessary to avoid N+1 queries over the serializer (I've done without it beforehand)
    # This however limits the capability of using the limit method from ActiveRecord in the serializer,
    # to limit the amout of data sent to the user if some folder has several children/documents.
  end

  def show
    render json: @folder
  end

  def create
    @folder = Folder.create!(folder_params)

    render json: @folder, status: :created, location: @folder
  end

  def update
    @folder.update(folder_params)

    render json: @folder
  end

  def destroy
    @folder.destroy
  end

  private

  def page
    params[:page]
  end

  def parent_id
    params[:parent_id]
  end

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :parent_id)
  end
end
