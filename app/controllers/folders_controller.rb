# frozen_string_literal: true

class FoldersController < ApplicationController
  def index
    @folders = Folder.roots
  end

  def show
    @folder = Folder.find(params[:id])
  end
end
