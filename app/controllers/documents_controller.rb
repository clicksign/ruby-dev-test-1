class DocumentsController < ApplicationController
  before_action :set_folder

  # GET /folders/:id/documents/new
  def new; end

  # POST /folders/:id/documents or /folders/:id/documents.json
  def create
    if @folder.documents.attach(params[:folder][:documents])
      redirect_to folder_url(@folder), notice: 'Document was successfully created.'
    else
      redirect_to folder_url(@folder), alert: "Errors: #{@folder.errors.full_messages.join(', ')}"
    end
  end

  # DELETE /folders/:id/documents/1 or /folders/:id/documents/1.json
  def destroy
    @folder.documents.find(params[:id]).purge
    redirect_to folder_url(@folder), notice: 'Document was successfully destroyed.'
  end

  private

  def set_folder
    @folder = Folder.find(params[:folder_id])
  end
end
