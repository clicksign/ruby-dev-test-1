# frozen_string_literal: true

class ArchivesController < ApplicationController
  before_action :set_archive, only: %i[edit update destroy]

  def new
    @archive = Archive.new(folder_id: folder_id_param[:folder_id])
  end

  def edit; end

  def create
    @archive = Archive.new(archive_params)

    if @archive.save
      if @archive.folder.present?
        folder = @archive.folder

        redirect_to folder_url(folder), notice: 'O arquivo foi criado com sucesso.'
      else
        redirect_to folders_url, notice: 'O arquivo foi criado com sucesso.'
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @archive.update(archive_params)
      if @archive.folder.present?
        folder = @archive.folder

        redirect_to folder_url(folder), notice: 'O arquivo foi atualizado com sucesso.'
      else
        redirect_to folders_url, notice: 'O arquivo foi atualizado com sucesso.'
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    parent_folder = @archive.folder if @archive.folder.present?

    @archive.destroy

    if parent_folder.present?
      redirect_to folder_url(parent_folder), notice: 'O arquivo foi deletado com sucesso.'
    else
      redirect_to folders_url, notice: 'O arquivo foi deletado com sucesso.'
    end
  end

  private

  def set_archive
    @archive = Archive.find(params[:id])
  end

  def archive_params
    params.require(:archive).permit(:name, :folder_id, :file)
  end

  def folder_id_param
    params.permit(:folder_id)
  end
end
