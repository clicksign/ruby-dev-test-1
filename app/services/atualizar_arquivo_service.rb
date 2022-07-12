class AtualizarArquivoService
  def mover(arquivo_id, params)
    arquivo = Arquivo.find(arquivo_id)
    arquivo.diretorio = Arquivo.find_by_id(params[:diretorio])
    arquivo.save
    arquivo
  end
end
