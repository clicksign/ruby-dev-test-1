class DocumentUploadsController < ApplicationController
  before_action :set_folder, only: %i[ new create destroy ]

  def new
  end

  def create
    @folder = Folder.find(params[:folder_id])
    @folder.documents.attach(params[:folder][:documents])
    redirect_to folder_path(@folder)
  end

  def destroy
    @folder = Folder.find(params[:folder_id])
    @folder.documents.find(params[:id]).purge
    redirect_to folder_path(@folder)
  end

  private 

  def set_folder
    @folder = Folder.find(params[:folder_id])
  end
end
