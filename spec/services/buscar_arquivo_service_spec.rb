require 'rails_helper'

describe BuscarArquivosService, type: :integration do
  before(:all) do
    @buscar_arquivo_service = BuscarArquivosService.new
    criar_pastas_e_arquivos
  end
  it 'busca um arquivo' do
    arquivo = @buscar_arquivo_service.buscar(3)

    expect(arquivo).to include({
                                 id: @pasta3.id,
                                 nome: @pasta3.nome,
                                 url: @pasta3.conteudo.url,
                                 arquivos: []
                               })
  end
  it 'busca uma pasta sem seus subarquivos' do
    arquivo = @buscar_arquivo_service.buscar(3)

    expect(arquivo).to include({
                                 id: @pasta3.id,
                                 nome: @pasta3.nome,
                                 url: nil,
                                 arquivos: []
                               })
  end
  it 'busca uma pasta e seus subarquivos' do
    arquivo = @buscar_arquivo_service.buscar(3, true)

    expect(arquivo).to include({
                                 id: @pasta3.id,
                                 nome: @pasta3.nome,
                                 url: nil,
                                 arquivos: [
                                   {
                                     id: @arquivo2.id,
                                     nome: @arquivo2.nome,
                                     url: @arquivo2.conteudo.url,
                                   }
                                 ]
                               })
  end
  it 'busca todos os arquivos sem subpastas e subarquivos' do
    arquivos = @buscar_arquivo_service.buscar_todos

    expect(arquivos).to eq([{ id: @pasta1.id,
                              nome: @pasta1.nome,
                              url: nil,
                              arquivos: [] }])
  end
  it 'busca todos os arquivos com subpastas e subarquivos' do
    arquivos = @buscar_arquivo_service.buscar_todos(true)

    expect(arquivos).to eq([{ id: @pasta1.id,
                              nome: @pasta1.nome,
                              url: nil,
                              arquivos: [{
                                           id: @pasta2.id,
                                           nome: @pasta2.nome,
                                           url: nil,
                                           arquivos: [{
                                                        id: @arquivo1.id,
                                                        nome: @arquivo1.nome,
                                                        url: @arquivo1.conteudo.url,
                                                      }] }, {
                                           id: @pasta3.id,
                                           nome: @pasta3.nome,
                                           url: nil,
                                           arquivos: [{
                                                        id: @arquivo2.id,
                                                        nome: @arquivo2.nome,
                                                        url: @arquivo2.conteudo.url,
                                                      }] }]
                            }])
  end
  it 'dar erro ao buscar um arquivo não existente' do
    expect { @buscar_arquivo_service.buscar(33, true) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end

def criar_pastas_e_arquivos
  @pasta1 = create(:pasta_valida)
  @pasta2 = create(:pasta_valida, diretorio: @pasta1)
  @pasta3 = create(:pasta_valida, diretorio: @pasta1)

  @arquivo1 = create(:arquivo_valido, diretorio: @pasta2)
  @arquivo2 = create(:arquivo_valido, diretorio: @pasta3)
end
