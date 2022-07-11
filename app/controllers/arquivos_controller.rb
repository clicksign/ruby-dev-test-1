class ArquivosController < ApplicationController
  before_action :set_arquivo, except: [:index, :new]
  before_action :set_arquivos_services, only: [:index]

  def index
    sub_diretorios = params[:sub_diretorios] == 'true'
    @arquivos = @arquivos_service.buscar_todos_os_arquivos(sub_diretorios)
    render json: @arquivos, status: :ok
  end

  def show
    render json: @arquivo, status: :ok
  end

  def new
  end

  def edit
  end

  private

  def set_arquivos_services
    @arquivos_service = ArquivosServices.new
  end

  def set_arquivo
    @arquivo = Arquivo.find(params[:id].to_i)
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end

end
