require 'rails_helper'

describe Arquivo, type: :model do
  it 'grava um arquivo válido com sucesso' do
    arquivo = build(:arquivo_valido)
    arquivo.save

    expect(Arquivo.count).to eq(1)
  end
  it 'grava um arquivo no s3 com sucesso' do
    arquivo = build(:arquivo_valido)
    arquivo.save

    expect(arquivo.conteudo.url).not_to be_nil
  end
  it 'grava um arquivo com um diretorio valido' do
    diretorio = create(:pasta_valida)
    arquivo = build(:arquivo_valido, diretorio: diretorio)
    arquivo.save

    expect(Arquivo.count).to eq(2)
  end
  it 'dar erro ao salvar quando o diretorio é invalido' do
    diretorio = create(:arquivo_valido)
    arquivo = build(:arquivo_valido, diretorio: diretorio)
    arquivo.save

    expect(Arquivo.count).to eq(1)
    expect(arquivo.errors[:diretorio]).to include("O diretório informado não é uma pasta")
  end
  it 'dar erro ao salvar arquivo sem nome' do
    arquivo = build(:arquivo_sem_nome)
    arquivo.save

    expect(Arquivo.count).to eq(0)
    expect(arquivo.errors[:nome]).to include("can't be blank")
  end
  it 'dar erro ao salvar um arquivo sem conteudo' do
    arquivo = build(:arquivo_sem_conteudo)
    arquivo.save

    expect(Arquivo.count).to eq(0)
    expect(arquivo.errors[:conteudo]).to include("O conteúdo do arquivo é obrigatório")
  end
  it 'grava uma pasta valida com sucesso' do
    arquivo = build(:pasta_valida)
    arquivo.save

    expect(Arquivo.count).to eq(1)
  end
  it 'dar erro ao salvar uma pasta com conteudo' do
    arquivo = build(:pasta_com_conteudo)
    arquivo.save

    expect(Arquivo.count).to eq(0)
    expect(arquivo.errors[:conteudo]).to include("Pasta não pode ter conteúdo")
  end
  it 'dar erro ao cadatrar arquivos com nomes iguais' do
    arquivo1 = create(:arquivo_valido)
    arquivo2 = build(:arquivo_valido, nome: arquivo1.nome)
    arquivo2.save

    expect(Arquivo.count).to eq(1)
    expect(arquivo2.errors[:nome]).to include("O diretório informado já comtém um arquivo com esse nome")
  end
  it 'dar erro ao cadatrar pastas com nomes iguais' do
    pasta1 = create(:pasta_valida)
    pasta2 = build(:pasta_valida, nome: pasta1.nome)
    pasta2.save

    expect(Arquivo.count).to eq(1)
    expect(pasta2.errors[:nome]).to include("O diretório informado já comtém um arquivo com esse nome")
  end
  it 'deleta pasta, subpastas e sub arquivos com sucesso' do
    pasta1 = create(:pasta_valida)
    create(:pasta_valida, diretorio: pasta1)
    create(:pasta_valida, diretorio: pasta1)
    create(:arquivo_valido, diretorio: pasta1)

    pasta2 = create(:pasta_valida, diretorio: pasta1)
    create(:arquivo_valido, diretorio: pasta2)
    create(:arquivo_valido, diretorio: pasta2)
    create(:arquivo_valido, diretorio: pasta2)
    create(:arquivo_valido, diretorio: pasta2)

    pasta2.destroy
    pasta1.destroy

    expect(Arquivo.count).to eq(0)
  end
end
