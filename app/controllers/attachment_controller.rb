class AttachmentController < ApplicationController

  def create
    attachment = Attachment.new(attachment_params)
    response = AttachmentService.new(attachment)

    render json: { }, status: :ok
  rescue Exception => e
    puts "!!!!! #{e.message}"
  end

  private

  def attachment_params
    params.require(:attachment).permit(:name).tap do |whitelisted|
      whitelisted[:data] = params[:attachment][:data]
    end
  end

end