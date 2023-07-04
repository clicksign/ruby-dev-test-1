# frozen_string_literal: true

class DirectoriesController < ApplicationController
  before_action :retrieve_directory, only: %i[edit update destroy]

  def index
    @directories = Directory.all
  end

  def show; end

  def new
    @directory = Directory.new
    @directory.subdirectories.build
    @directory.file_items.build
  end

  def edit; end

  def create
    @directory = Directory.new(directory_params)

    if @directory.save
      redirect_to directories_path
    else
      render :new
    end
  end

  def update
    if @directories.update(directory_params)
      redirect_to directories_path
    else
      render :edit
    end
  end

  def destroy
    if @directories.destroy
      redirect_to directories_path
    else
      render :index, notice: 'Error'
    end
  end

  private

  def retrieve_directory
    @directories = Directory.find(params[:id])
  end

  def directory_params
    params.require(:directory).permit(:name, :content,
                                      subdirectories_attributes: %i[id name content],
                                      file_items_attributes: %i[id name content])
  end
end
