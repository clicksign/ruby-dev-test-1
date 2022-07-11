class CriarArquivoService
  def create(params)
    arquivo = Arquivo.new({ nome: params[:nome], pasta: params[:pasta]})
    arquivo.diretorio = Arquivo.find_by_id(params[:diretorio])

    formatar_nome_arquivo(arquivo)
    montar_caminho(arquivo)
    anexar_arquivo(arquivo, params[:conteudo])

    arquivo.save
    arquivo
  end

  private

  def formatar_nome_arquivo(arquivo)
    arquivo.nome = ActiveStorage::Filename.new(arquivo.nome).sanitized
  end

  def anexar_arquivo(arquivo, conteudo)
    return if conteudo.nil? || conteudo.blank?

    conteudo_decodificado = conteudo_decodificado(conteudo, arquivo.nome)
    arquivo.conteudo.attach(conteudo_decodificado)
  end

  def montar_caminho(arquivo)
    if arquivo.diretorio.nil?
      arquivo.caminho = '/'
    else
      arquivo.caminho = arquivo.diretorio.caminho_completo
    end
  end

  def conteudo_decodificado(base_64, file_name)
    base_64_decodificado = Base64.decode64(base_64)
    {
      io: StringIO.new(base_64_decodificado),
      filename: file_name
    }
  end
end
