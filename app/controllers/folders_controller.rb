class FoldersController < ApplicationController
  def index
    @folders = Folder.where(folder_id: nil).order(:description)
  end

  def show
    @folder = Folder.includes(:folder).where(id: params[:id]).take
  end
end
