class DeletarArquivosService
  def deletar(arquivo_id)
    arquivo = Arquivo.find(arquivo_id)
    arquivo.destroy
  end
end
