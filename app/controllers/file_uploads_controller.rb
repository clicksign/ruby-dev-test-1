class FileUploadsController < ApplicationController
  def index
    @arquivos = FileUpload.order(id: :desc)
  end
end
