class LocalFilesController < ApplicationController
  def create
    local_file_creator = Files::CreateLocalFile.new(params: local_file_params)
    local_file_creator.save

    head :created
  rescue StandardError => e
    render json: e.message, status: :unprocessable_entity
  end

  private

  def local_file_params
    params.require(:local_file).permit(:name, :attached).merge(folder_id: params[:folder_id])
  end
end
