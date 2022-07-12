class CriarArquivoService
  def create(params)
    arquivo = Arquivo.new({ nome: params[:nome], pasta: params[:pasta]})
    arquivo.diretorio = Arquivo.find(params[:diretorio]) unless params[:diretorio].blank?

    formatar_nome_arquivo(arquivo)
    anexar_arquivo(arquivo, params[:conteudo])

    arquivo.save
    arquivo
  end

  private

  def formatar_nome_arquivo(arquivo)
    arquivo.nome = ActiveStorage::Filename.new(arquivo.nome).sanitized unless arquivo.nome.nil?
  end

  def anexar_arquivo(arquivo, conteudo)
    return if conteudo.nil? || conteudo.blank?
    return if arquivo.nome.nil? || arquivo.nome.blank?

    conteudo_decodificado = conteudo_decodificado(conteudo, arquivo.nome)
    arquivo.conteudo.attach(conteudo_decodificado)
  end

  def conteudo_decodificado(base_64, file_name)
    base_64_decodificado = Base64.decode64(base_64)
    {
      io: StringIO.new(base_64_decodificado),
      filename: file_name
    }
  end
end
