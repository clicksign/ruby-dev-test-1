class AtualizarArquivoService
  def mover(arquivo_id, params)
    arquivo = Arquivo.find(arquivo_id)
    arquivo.diretorio = Arquivo.find_by_id(params[:diretorio])

    montar_caminho(arquivo)

    arquivo.save
    arquivo
  end

  private

  def montar_caminho(arquivo)
    if arquivo.diretorio_id.nil?
      arquivo.caminho = '/'
    else
      arquivo.caminho = arquivo.diretorio.caminho_completo
    end
  end
end
