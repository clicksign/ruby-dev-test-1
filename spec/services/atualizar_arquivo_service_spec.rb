require 'rails_helper'

describe AtualizarArquivoService, type: :integration do
  before(:each) do
    @atualizar_arquivo_service = AtualizarArquivoService.new
    @conteudo = Base64.encode64(File.open("#{Rails.root}/spec/support/attachments/image.png").read)
  end
  it 'altera o diretório de um arquivo' do
    diretorio_origem = create(:pasta_valida)
    diretorio_destino = create(:pasta_valida)
    arquivo = create(:arquivo_valido, diretorio: diretorio_origem)

    expect(Arquivo.count).to eq(3)
    expect(arquivo.id).not_to be_nil
    expect(arquivo.diretorio_id).to eq(diretorio_origem.id)

    @atualizar_arquivo_service.mover(3, { diretorio: '2' })

    arquivo = Arquivo.find(arquivo.id)
    expect(arquivo.diretorio_id).to eq(diretorio_destino.id)
  end
  it 'dar erro ao mover o arquivo para eles mesmo' do
    create(:arquivo_valido)
    arquivo_atualizado = @atualizar_arquivo_service.mover(1, { diretorio: '1' })
    arquivo_criado = Arquivo.find(1)

    expect(Arquivo.count).to eq(1)
    expect(arquivo_atualizado.errors[:diretorio]).to include("O arquivo não ter ele mesmo como diretorio")
    expect(arquivo_criado.diretorio_id).to be_nil
  end
  it 'dar erro ao mudar para um direroio que é um arquivo' do
    create_list(:arquivo_valido, 2)
    arquivo_atualizado = @atualizar_arquivo_service.mover(2, { diretorio: '1' })

    expect(Arquivo.count).to eq(2)
    expect(arquivo_atualizado.errors[:diretorio]).to include("O diretório informado não é uma pasta")
  end
  it 'dar erro ao mudar para um direroio que não existe' do
    arquivo = create(:arquivo_valido)

    expect { @atualizar_arquivo_service.mover(1, { diretorio: '2' }) }.to raise_error(ActiveRecord::RecordNotFound)
    arquivo = Arquivo.find(arquivo.id)
    expect(arquivo.diretorio_id).to be_nil
  end
end
