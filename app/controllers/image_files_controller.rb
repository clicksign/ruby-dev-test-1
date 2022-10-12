class ImageFilesController < ApplicationController
  before_action :find_image_file!, only: [:show, :destroy]

  attr_accessor :image_file

  def add_new
    @image_file = ImageFile.new(directory_id: params[:directory_id])

    render 'new'
  end

  def create
    @image_file = ImageFile.new(image_file_params)
    
    if @image_file.save
      flash[:success] = 'Arquivo salvo.'
      redirect_to directory_path(@image_file.directory_id)

    else
      flash[:danger] = "Erro ao salvar arquivo. #{@image_file.errors.full_messages.first}"
      redirect_to add_new_image_file_path(directory_id: @image_file.directory_id)
    end
  end

  def show
    @image_file = image_file
    @document = @image_file.document
  end

  def destroy
    if image_file.destroy
      flash[:success] = 'Arquivo excluído com sucesso.'
      redirect_back(fallback_location: root_path)
    else
      flash[:success] = 'Erro ao excluir arquivo.'
      redirect_back(fallback_location: root_path)
    end
  end

  private

  def image_file_params
    params.require(:image_file).permit(:name, :directory_id, :document)
  end

  def find_image_file!
    @image_file = ImageFile.find(params[:id])
  end
end