class FilesController < ApplicationController
  before_action :load_folder

  def new
  end

  def create
    @folder.files.attach(params[:files])
    redirect_to folder_path(@folder)
  end

  private

  def load_folder
    @folder = Folder.find(params[:folder_id])
  end
end
