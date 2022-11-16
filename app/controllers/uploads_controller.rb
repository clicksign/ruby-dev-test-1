class UploadsController < ApplicationController

  def index
    @uploads = Upload.all
  end

  def create
    response = UploadService.new(uploads_params)

    respond_to do |format|
      format.json { render json: response, status: :ok }
    end
  rescue Exception => e
    puts "!!!!! #{e.message}"

    render json: { message: "#{e.message}"}, status: 500
  end

  private

  def uploads_params
    params.require(:upload).permit(:title, info: {})
  end

end