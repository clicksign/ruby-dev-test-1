class FoldersController < ApplicationController
  def create
    folder = Folder.new folder_params

    if folder.save
      head :created
    else
      render json: folder.errors, status: :unprocessable_entity
    end
  end

  private

  def folder_params
    params.require(:folder).permit(:label)
  end
end
