class LocalFilesController < ApplicationController
  def create
    local_file = LocalFile.new local_file_params

    if local_file.save
      head :created
    else
      render json: local_file.errors, status: :unprocessable_entity
    end
  end

  private

  def local_file_params
    params.require(:local_file).permit(:label, :attached).merge(folder_id: @params[:folder_id])
  end
end
