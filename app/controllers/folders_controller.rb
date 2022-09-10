# frozen_string_literal: true

# FoldesController
class FoldersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_folder, only: %i[show edit update destroy]
  before_action :set_parent, only: %i[destroy]

  def index
    @folder = current_user.folders.where(name: 'Root').first
    @current_folder_child = @folder
    @folders = @folder.children
  end

  def show
    @folders = @folder.children
    @current_folder_child = @folder
  end

  def create
    @folder = Folder.new(folder_params)

    @folder.parent = current_user.folders.where(name: 'Root').first unless folder_params[:parent_id]
    @folder.user = current_user

    respond_to do |format|
      if @folder.save
        format.html { redirect_to folder_path(@folder.parent), notice: 'Folder was successfully created.' }
      else
        format.html { redirect_to folder_path(@folder.parent), status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @folder.update(folder_params)
        format.html { redirect_to folder_url(@folder.parent), notice: 'Folder was successfully updated.' }
      else
        format.html { redirect_to folder_path(@folder.parent), status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      unless @parent.nil?
        @folder.destroy
        format.html { redirect_to folder_url(@parent), notice: 'Folder was successfully destroyed.' }
      end

      format.html { redirect_to folder_url(@parent), notice: 'Root folder cannot be destroyed.', status: :unprocessable_entity }
    end
  end

  private

  def set_folder
    @folder = current_user.folders.find(params[:id].to_i)
  end

  def folder_params
    params.require(:folder).permit(:name, :parent_id)
  end

  def set_parent
    @parent = @folder.parent
  end
end
