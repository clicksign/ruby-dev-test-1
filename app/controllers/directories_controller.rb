class DirectoriesController < ApplicationController
  before_action :find_directory!, only: [:show, :edit, :update, :destroy]

  attr_accessor :directory

  def index
    @directories = Directory.includes(:sub_directories, :image_files).where(parent_directory_id: nil)
  end

  def show
    @directory = directory
    @informations = directory.sub_directories + directory.image_files
  end

  def edit
    @directory = directory
  end

  def update
    if directory.update(directory_params)
      flash[:success] = 'Nome do diretório editado.'
      redirect_to directories_path

    else
      flash[:danger] = "#{error_messages(@directory.errors.full_messages)}"
      redirect_back(fallback_location: root_path)
    end
  end

  def add_new
    if params[:parent_directory_id].to_i == 0
      Directory.create!

    else
      Directory.create!(parent_directory_id: params[:parent_directory_id])
    end

    flash[:success] = 'Diretório criado.'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    if directory.destroy
      flash[:success] = 'Diretório excluído com sucesso.'
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = 'Erro ao excluir diretório.'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def directory_params
    params.require(:directory).permit(:name)
  end

  def find_directory!
    @directory = Directory.includes(:sub_directories, :image_files).find(params[:id])
  end
end
