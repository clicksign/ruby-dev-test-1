# frozen_string_literal: true

class FolderFilesController < ApplicationController
  before_action :set_folder_file, only: [:destroy]

  def create
    @folder_file = FolderFile.new(folder_file_params)
    redirect_url = @folder_file.folder ? folder_path(@folder_file.folder) : folders_path

    if @folder_file.save
      redirect_to redirect_url, notice: 'File was successfully uploaded.'
    else
      redirect_to redirect_url, alert: @folder_file.errors.full_messages.join(', ')
    end
  end

  def destroy
    redirect_url = @folder_file.folder ? folder_path(@folder_file.folder) : folders_path

    if @folder_file.destroy
      redirect_to redirect_url, notice: 'File was successfully destroyed.'
    else
      redirect_back fallback_location: root_path, alert: @folder_file.errors.full_messages.join(', ')
    end
  end

  private

  def set_folder_file
    @folder_file = FolderFile.find(params[:id])
  end

  def folder_file_params
    params.require(:folder_file).permit(:folder_id, :file)
  end
end
