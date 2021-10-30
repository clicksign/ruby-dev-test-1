class FileUploadsController < ApplicationController
  def new
    @directory = Directory.find(params[:directory_id])
  end

  def create
    @directory = Directory.find(params[:directory_id])
    @directory.files.attach(params[:directory][:files])
    redirect_to directory_path(@directory)
  end

  def destroy
    @directory = Directory.find(params[:directory_id])
    @directory.files.find(params[:id]).purge
    redirect_to directory_path(@directory)
  end
end
