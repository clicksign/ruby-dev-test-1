class FoldersController < ApplicationController
  before_action :filter_current_folder, :build_new_app_folder, :build_new_app_file

  def index
    @folders = params[:id].present? ? AppFolder.find(params[:id]).children : AppFolder.root_folders
    @files   = params[:id].present? ? AppFile.where(app_folder_id: params[:id]) : AppFile.root_files
  end

  def create
    app_folder    = AppFolder.new(app_folder_params)
    redirect_path = app_folder.parent.present? ? root_path(id: app_folder.parent.id) : root_path
      
    if app_folder.save
        redirect_to redirect_path
    else
      redirect_to redirect_path, alert: app_folder.errors.full_messages.join(', ')
    end
  end

  def destroy
    app_folder    = AppFolder.find(params[:id])
    redirect_path = app_folder.parent.present? ? root_path(id: app_folder.parent.id) : root_path
      
    if app_folder.destroy
        redirect_to redirect_path
    else
      redirect_to redirect_path, alert: app_folder.errors.full_messages.join(', ')
    end
  end

  private

  def build_breadcrumb_records
    return [] unless @current_folder

    all_records = []
    if @current_folder
      all_records << @current_folder.id

    end
  end

  def build_new_app_folder
    @new_app_folder = AppFolder.new(parent_id: params[:id])
  end

  def build_new_app_file
    @new_app_file = AppFile.new(app_folder_id: params[:id])
  end

  def app_folder_params
    params.require(:app_folder).permit(:folder_name, :parent_id)
  end

  def filter_current_folder
    return unless params[:id]

    @current_folder = AppFolder.find(params[:id])
  end
end
