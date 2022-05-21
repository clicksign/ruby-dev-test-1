class DirectoriesController < ApplicationController
  before_action :set_directory, only: %i[ edit update destroy ]
  before_action :set_current_directory, only: %i[ show new ]
  before_action :build_directory, only: %i[ index show new]
  before_action :build_archive, only: %i[ show ]

  def index
    load_directories()
  end

  def show
    @directories = @current_directory.child_directories
    @archives = @current_directory.archives

    render :index
  end

  def new
    render :form
  end

  def edit
    render :form
  end

  def create
    @directory = Directory.new(directory_params)
    if @directory.save
      load_directories(@directory)
      build_directory()
    end
  end

  def update
    @directory.update(directory_params)
    load_directories(@directory)

    render :create
  end

  def destroy
    load_directories(@directory)
    @directory.destroy

  end

  private
    def set_directory
      @directory = Directory.find(params[:id])
    end

    def set_current_directory
      @current_directory = Directory.find(params[:id]) if params[:id].present?
    end

    def directory_params
      params.require(:directory).permit(:name, :parent_id)
    end

    def build_directory
      @directory = Directory.new
    end

    def build_archive
      @archive = Archive.new
    end

    def load_directories(directory = nil)
      @archives = directory&.parent&.archives || []
      directory&.parent_id.present? ? @directories = Directory.where(parent_id: directory.parent_id) : @directories = Directory.where(parent_id: nil)
    end
end
