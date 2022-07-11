class ArquivosServices
  def buscar_todos(sub_diretorios = false)
    arquivos = Arquivo.diretorios_raiz.all
    if sub_diretorios
      tratar_arquivos_e_sub_arquivos(arquivos)
    else
      tratar_arquivos(arquivos)
    end
  end

  def buscar(id, sub_diretorios = false)
    arquivo = Arquivo.find(id)
    if sub_diretorios
      tratar_arquivos_e_sub_arquivos([arquivo])
    else
      tratar_arquivos([arquivo])
    end
  end

  private

  def tratar_arquivos(arquivos)
    saida = []
    arquivos&.each do |arquivo|
      arquivo_simplificado = tratar_arquivo(arquivo)
      saida.push(arquivo_simplificado)
    end
    saida
  end

  def tratar_arquivos_e_sub_arquivos(arquivos)
    saida = []
    arquivos&.each do |arquivo|
      sub_arquivos = tratar_arquivos_e_sub_arquivos(arquivo.arquivos)
      arquivo_simplificado = tratar_arquivo(arquivo, sub_arquivos)
      saida.push(arquivo_simplificado)
    end
    saida
  end

  def tratar_arquivo(arquivo, sub_arquivos = [])
    saida = {
      id: arquivo.id,
      path: arquivo.path,
      nome: arquivo.name,
    }
    if arquivo.pasta?
      saida[:arquivos] = sub_arquivos
    end
    saida
  end
end
