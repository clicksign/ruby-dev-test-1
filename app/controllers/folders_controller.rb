class FoldersController < ApplicationController
  before_action :set_folder, only: :show
  require 'pry'
  def index
    @folders = Folder.where(ref_id: nil).order(created_at: :desc)
  end

  def show
    @folders = @folder.subfolders.order(created_at: :desc)
  end

  def new
    @folder = Folder.new
  end

  def new_file
    # binding.pry
    @folder = current_folder
  end

  def new_file_upload
    # binding.pry
    @file = current_folder
    @file.files.attach(folder_params[:files])
    redirect_to folder_path(@file.id)
  end

  def create
    @folder = Folder.new(
      name: folder_params[:folder_name],
      path: "#{current_folder.path}/#{folder_params[:folder_name]}",
      ref_id: current_folder.id
    )

    respond_to do |format|
      if @folder.save
        format.html { redirect_to folder_url(@folder) }
        format.json { render :show, status: :created, location: @folder }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @folder.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def set_folder
      @folder = Folder.find(params[:id])
    end

    def current_folder
      @current_folder = Folder.find(params[:current_folder].to_i)
    end

    def folder_params
      params.require(:folder).permit(:folder_name, :files)
    end
end
