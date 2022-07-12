class AtualizarArquivoService
  def mover(arquivo_id, params)
    arquivo = Arquivo.find(arquivo_id)
    arquivo.diretorio = Arquivo.find(params[:diretorio]) unless params[:diretorio].blank?
    arquivo.save
    arquivo
  end
end
