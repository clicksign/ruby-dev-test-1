class UploadsController < ApplicationController

  def index
    @uploads = Upload.all
  end

  def create
    response = UploadService.new(params)
    upload = Upload.new(title: Faker::Ancient.titan, info: response).save!

    # upload.files.attach(io: File.open("../../Downloads/me.jpg"), filename: "something")
    # attach uid
    
    upload.files.attach(io: File.open("../../Downloads/me.jpg"), filename: "something")

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