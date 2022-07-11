class ArquivosController < ApplicationController
  before_action :set_arquivos_services, only: [:index, :show]

  def index
    @arquivos = @arquivos_service.buscar_todos(carregar_sub_pastas?)
    render json: @arquivos, status: :ok
  end

  def show
    @arquivo =  @arquivos_service.buscar(params[:id].to_i, carregar_sub_pastas?)
    render json: @arquivo, status: :ok
  end

  def new
  end

  def edit
  end

  private

  def carregar_sub_pastas?
    parse_boolean(params[:sub_pastas])
  end

  def set_arquivos_services
    @arquivos_service = ArquivosServices.new
  end

  def set_arquivo
    @arquivo = Arquivo.find(params[:id].to_i)
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end

end
