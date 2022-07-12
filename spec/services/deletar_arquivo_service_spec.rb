require 'rails_helper'

class DeletarArquivoServiceSpec < ActiveSupport::TestCase
  RSpec.describe DeletarArquivosService, type: :integration do
    before(:each) do
      @criar_arquivo_service = CriarArquivoService.new
      @deletar_arquivo_service = DeletarArquivosService.new
      @conteudo = Base64.encode64(File.open("#{Rails.root}/spec/support/attachments/image.png").read)
    end
    it 'deleta um arquivo e conteúdo' do
      arquivo = create(:arquivo_valido)

      expect(arquivo.id).not_to be_nil
      expect(ActiveStorage::Attachment.where(record: arquivo).count).to eq(1)

      @deletar_arquivo_service.deletar(arquivo.id)

      expect(Arquivo.count).to eq(0)
      expect(ActiveStorage::Attachment.where(record: arquivo).count).to eq(0)
    end
    it 'deleta uma pasta, toda árvore de arquivos subjacentes e conteúdo' do
      arquivos_params = [
        { nome: "Pasta 1", pasta: true }, # id = 1
        { nome: "Pasta 2", pasta: true, diretorio: '1' }, # id = 2
        { nome: "Pasta 3", pasta: true, diretorio: '2' }, # id = 3
        { nome: "Arquivo 1", pasta: false, conteudo: @conteudo, diretorio: 3 }, # id = 4
        { nome: "Arquivo 2", pasta: false, conteudo: @conteudo, diretorio: 3 }, # id = 5
      ]

      arquivos_params.each do |arquivo_params|
        @criar_arquivo_service.create(arquivo_params)
      end

      expect(Arquivo.count).to eq(5)
      expect(ActiveStorage::Attachment.where(record_type: :Arquivo).count).to eq(2)

      @deletar_arquivo_service.deletar(1)

      expect(Arquivo.count).to eq(0)
      expect(ActiveStorage::Attachment.where(record_type: :Arquivo).count).to eq(0)
    end
    it 'dar erro ao deletar um inexistente' do
      expect { @deletar_arquivo_service.deletar(2) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
