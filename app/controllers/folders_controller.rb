# frozen_string_literal: true

class FoldersController < ApplicationController
  before_action :set_folder, only: [:show, :destroy]

  def index
    @folders = Folder.roots.ordered_by_name
    @folder_files = FolderFile.roots
  end

  def show
    @folders = Folder.children_of(@folder).ordered_by_name
    @folder_files = @folder.folder_files
  end

  def create
    @folder = Folder.new(folder_params)
    if @folder.save
      redirect_to @folder, notice: 'Folder was successfully created.'
    else
      redirect_back fallback_location: root_path, alert: @folder.errors.full_messages.join(', ')
    end
  end

  def destroy
    redirect_url = @folder.parent ? folder_path(@folder.parent) : folders_path

    if @folder.destroy
      redirect_to redirect_url, notice: 'Folder was successfully destroyed.'
    else
      redirect_back fallback_location: root_path, alert: @folder.errors.full_messages.join(', ')
    end
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def folder_params
    params.require(:folder).permit(:name, :parent_id)
  end
end
