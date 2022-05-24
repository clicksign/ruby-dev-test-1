class FoldersController < ApplicationController
  before_action :filter_current_folder

  def index
    @folders = params[:id].present? ? AppFolder.find(params[:id]).children : AppFolder.root_folders
    @files   = params[:id].present? ? AppFile.where(app_folder_id: params[:id]) : AppFile.root_files
  end

  private

  def filter_current_folder
    return unless params[:id]

    @current_folder = AppFolder.find(params[:id])
  end
end
