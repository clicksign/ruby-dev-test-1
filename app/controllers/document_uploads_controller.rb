class DocumentUploadsController < ApplicationController
  before_action :set_folder, only: %i[ new create destroy ]

  def new
  end

  def create
    @bucket = Bucket.find(params[:bucket_id])
    @bucket.files.attach(params[:bucket][:files])
    redirect_to bucket_path(@bucket)
  end

  private 

  def set_folder
    @folder = Folder.find(params[:folder_id])
  end
end
