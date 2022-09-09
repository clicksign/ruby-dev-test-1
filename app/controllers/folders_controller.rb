# frozen_string_literal: true

# FoldesController
class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: %i[show edit update destroy]

  def index
    @folder = current_user.folders.where(name: 'root').first
    @current_folder_child = @folder
    @folders = @folder.children
  end

  def show
    @folders = @folder.children
    @current_folder_child = @folder
  end

  def new
    @folder = Folder.new
  end

  def edit; end

  def create
    @folder = Folder.new(folder_params)

    @folder.parent = current_user.folders.where(name: 'root').first unless folder_params[:parent_id]
    @folder.user = current_user

    respond_to do |format|
      if @folder.save
        format.html { redirect_to folder_path(@folder.parent), notice: 'Folder was successfully created.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to folder_url(@folder.parent), notice: 'Folder was successfully updated.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    parent = @folder.parent
    @folder.destroy

    respond_to do |format|
      format.html { redirect_to folder_url(parent), notice: 'Folder was successfully destroyed.' }
    end
  end

  private

  def set_folder
    @folder = current_user.folders.find(params[:id].to_i)
  end

  def folder_params
    params.require(:folder).permit(:name, :parent_id)
  end
end
