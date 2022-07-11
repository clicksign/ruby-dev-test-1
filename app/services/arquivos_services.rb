class ArquivosServices
  def buscar_todos_os_arquivos(sub_diretorios = false)
    arquivos = Arquivo.diretorios_raiz
    tratar_arquivos(arquivos, sub_diretorios)
  end

  private

  def tratar_arquivos(arquivos_brutos, sub_diretorios = false)
    arquivos = []
    arquivos_brutos.each do |arquivo|
      if sub_diretorios
        sub_arquivos = tratar_arquivos(arquivo.arquivos, sub_diretorios)
        arquivo_simplificado = tratar_arquivo(arquivo, sub_arquivos)
      else
        arquivo_simplificado = tratar_arquivo(arquivo)
      end
      arquivos.push(arquivo_simplificado)
    end

    arquivos
  end

  def tratar_arquivo(arquivo, subarquivos = [])
    novo_arquivo = {
      id: arquivo.id,
      path: arquivo.path,
      nome: arquivo.name,
    }

    if arquivo.pasta?
      novo_arquivo[:arquivos] = subarquivos
    end

    novo_arquivo
  end
end
