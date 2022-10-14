class FilesController < ApplicationController
  before_action :set_folder
  before_action :set_file, only: [:destroy]

  def index
    @attachments = @folder.files.includes(:blob)
    render json: @attachments, each_serializer: FileSerializer
  end

  def create
    @file = @folder.files.attach(file_params)
  end

  def destroy
    @file.purge
  end

  private

  def set_folder
    @folder = Folder.find(params[:folder_id])
  end

  def set_file
    @file = @folder.files.find(params[:id])
  end

  def file_params
    params.require(:file)
  end
end
