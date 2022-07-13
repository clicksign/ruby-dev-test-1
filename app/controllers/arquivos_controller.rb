class ArquivosController < ApplicationController
  before_action :set_arquivos_services, only: [:index, :show]

  def index
    @arquivos = @arquivos_service.buscar_todos(carregar_sub_pastas?)
    render json: @arquivos, status: :ok
  end

  def show
    @arquivo =  @arquivos_service.buscar(params[:id].to_i, carregar_sub_pastas?)
    render json: @arquivo, status: :ok
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end

  def create
    @criar_arquivo_service = CriarArquivoService.new
    @arquivo = @criar_arquivo_service.create(create_params)

    if !@arquivo.errors.empty?
      render json: { errors: @arquivo.errors }, status: :unprocessable_entity
    else
      render status: :created
    end
  end

  def update
    @atualizar_arquivo_service = AtualizarArquivoService.new
    @arquivo = @atualizar_arquivo_service.mover(params[:id], update_params)

    if !@arquivo.errors.empty?
      render json: { errors: @arquivo.errors }, status: :unprocessable_entity
    else
      render status: :created
    end
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end

  def destroy
    DeletarArquivosService.new.deletar(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end

  private

  def create_params
    params.permit(:nome, :pasta, :conteudo, :diretorio)
  end

  def update_params
    params.permit(:diretorio)
  end

  def carregar_sub_pastas?
    parse_boolean(params[:sub_pastas])
  end

  def set_arquivos_services
    @arquivos_service = BuscarArquivosService.new
  end

  def set_arquivo
    @arquivo = Arquivo.find(params[:id].to_i)
  rescue ActiveRecord::RecordNotFound => e
    render json: { message: e.message }, status: :not_found
  end

end
