class UploadController < ApplicationController

  def index
    @uploads = Upload.all

    render json: { }, status: :ok
  end

  def create
    response = UploadService.new(params)

    render json: response, status: :ok
  rescue Exception => e
    puts "!!!!! #{e.message}"

    render json: { message: "#{e.message}"}, status: :ok
  end

  private

  # def uploads_params
  #   params.require(:upload).permit(:title, info: {})
  # end


end