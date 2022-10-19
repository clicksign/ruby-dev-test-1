class DocumentsController < ApplicationController
  before_action :set_document, only: [:show, :update, :destroy]

  before_action do
    ActiveStorage::Current.host = request.base_url
  end

  def index
    @documents = Document.all.where(folder_id:)

    render json: @documents.paginate(page:)
  end

  def show
    render json: @document
  end

  def create
    @document = Document.create!(document_params)
    render json: @document, status: :created
  end

  def update
    @document.update!(document_params)

    render json: @document
  end

  def destroy
    @document.destroy
  end

  private

  def folder_id
    params[:folder_id]
  end

  def page
    params[:page]
  end

  def set_document
    @document = Document.find(params[:id])
  end

  def document_params
    params.require(:document).permit(:name, :content, :folder_id, :file)
  end
end
