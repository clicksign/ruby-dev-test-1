# frozen_string_literal: true

# DocumentsController
class DocumentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_document, only: %i[edit update destroy]
  before_action :file_purge, only: %i[destroy]
  before_action :set_folder_reference, only: %i[destroy]

  def create
    @document = Document.new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to folder_path(@document.folder), notice: 'Document was successfully created.' }
      else
        format.html { redirect_to folder_path(@document.folder), status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to folder_url(@document.folder), notice: 'Document was successfully updated.' }
      else
        format.html { redirect_to folder_path(@document.folder), status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @document.destroy

    respond_to do |format|
      format.html { redirect_to folder_url(@folder_reference), notice: 'Document was successfully destroyed.' }
    end
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:title, :description, :file, :folder_id)
  end

  def file_purge
    @document.file.purge
  end

  def set_folder_reference
    @folder_reference = @document.folder
  end
end
