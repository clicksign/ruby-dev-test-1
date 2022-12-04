class FileUploadsController < ApplicationController
  def index
    @file_uploads = FileUpload.only_parents.order(created_at: :desc)
  end

  def new
    @file_upload = FileUpload.new
  end

  def create
    @file_upload = FileUpload.new(file_upload_params)
    if @file_upload.save
      redirect_to file_uploads_path, notice: "#{@file_upload.description} was successfully created."
    else
      redirect_to file_uploads_path, alert: @file_upload.errors.full_messages.to_sentence
    end
  end

  private

  def file_upload_params
    params.require(:file_upload).permit(:description, :parent_id, files: [])
  end
end
