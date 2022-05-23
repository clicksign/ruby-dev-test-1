class FoldersController < ApplicationController

  def index
    @folders = Folder.from_root
  end

  def show
    @folder = Folder.find(params[:id])
  end
end