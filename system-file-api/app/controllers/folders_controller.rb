# frozen_string_literal: true

class FoldersController < ApplicationController
  def create
    FolderCreateAction.new.perform(folder_params)
                      .and_then { |folder:| render json: FolderSerializer.render_as_hash(folder), status: :created }
                      .or_else { |errors| render json: { errors: errors }, status: :unprocessable_entity }
  end

  def update
    FolderUpdateAction.new.perform(params[:id], folder_params)
                      .and_then { |folder:| render json: FolderSerializer.render_as_hash(folder), status: :ok }
                      .or_else { |errors| render json: { errors: errors }, status: :unprocessable_entity }
  end

  def destroy
    FolderDeleteAction.new.perform(params[:id])
    head :no_content
  end

  def show
    FolderShowAction.new.perform(params[:id]).and_then do |folder:|
      render json: FolderSerializer.render_as_hash(folder)
    end
  end

  def childrens
    FolderListChildrensAction.new.perform(params[:id]).and_then do |folders:|
      render json: FolderSerializer.render_as_hash(folders)
    end
  end

  def index
    FolderListParentsAction.new.perform.and_then do |folders:|
      render json: FolderSerializer.render_as_hash(folders)
    end
  end

  private

  def folder_params
    params.permit(:name, :folder_id)
  end
end
