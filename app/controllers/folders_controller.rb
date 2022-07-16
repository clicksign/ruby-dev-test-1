# frozen_string_literal: true

class FoldersController < ApplicationController
  before_action :set_folder, only: %i[edit update destroy]
  before_action :set_folder_with_content, only: :show

  def index
    @folders = Folder.roots.includes(:archives)
    @archives = Archive.roots
  end

  def show
    @path_name = @folder_with_content.path + @folder_with_content.name
  end

  def new
    @folder = Folder.new(parent_id: parent_id_param[:parent_id])
  end

  def edit; end

  def create
    @folder = Folder.new(folder_params)

    if @folder.save
      @folder = @folder.parent if @folder.parent.present?

      redirect_to folder_url(@folder), notice: 'A pasta foi criada com sucesso.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @folder.update(folder_params)
      @folder = @folder.parent if @folder.parent.present?

      redirect_to folder_url(@folder), notice: 'A pasta foi atualizada com sucesso.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    parent_folder = @folder.parent if @folder.parent.present?

    @folder.destroy

    if parent_folder.present?
      redirect_to folder_url(parent_folder), notice: 'A pasta foi deletada com sucesso.'
    else
      redirect_to folders_url, notice: 'A pasta foi deletada com sucesso.'
    end
  end

  private

  def set_folder
    @folder = Folder.find(params[:id])
  end

  def set_folder_with_content
    @folder_with_content = Folder.where(id: params[:id]).includes(:children, :archives).first
  end

  def folder_params
    params.require(:folder).permit(:name, :parent_id)
  end

  def parent_id_param
    params.permit(:parent_id)
  end
end
