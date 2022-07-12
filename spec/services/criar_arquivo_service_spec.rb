require 'rails_helper'

class CriarArquivoServiceSpec < ActiveSupport::TestCase
  RSpec.describe CriarArquivoService, type: :model do
    before(:each) do
      @criar_arquivo_service = CriarArquivoService.new
      @conteudo = Base64.encode64(File.open("#{Rails.root}/spec/support/attachments/image.png").read)
    end
    it 'grava um arquivo válido' do
      arquivo_params = { nome: "Teste", pasta: false, conteudo: @conteudo, diretorio: "" }
      @criar_arquivo_service.create(arquivo_params)

      arquivo_criado = Arquivo.find(1)

      expect(Arquivo.count).to eq(1)
      expect(arquivo_criado.nome).to eq("Teste")
      expect(arquivo_criado.conteudo.attached?).to eq(true)
      expect(arquivo_criado.pasta).to eq(false)
    end
    it 'grava uma pasta válida' do
      arquivo_params = { nome: "Teste", pasta: true, diretorio: "" }
      @criar_arquivo_service.create(arquivo_params)

      arquivo_criado = Arquivo.find(1)

      expect(Arquivo.count).to eq(1)
      expect(arquivo_criado.nome).to eq("Teste")
      expect(arquivo_criado.conteudo.blank?).to eq(true)
      expect(arquivo_criado.diretorio).to be_nil
      expect(arquivo_criado.pasta).to eq(true)
    end
    it 'grava um arquivo dentro de um diretorio' do
      diretorio = create(:pasta_valida)
      arquivo_params = { nome: "Teste", pasta: false, conteudo: @conteudo, diretorio: diretorio.id }
      @criar_arquivo_service.create(arquivo_params)
      arquivo_criado = Arquivo.find(2)

      expect(arquivo_criado.diretorio_id).to eq(diretorio.id)
      expect(Arquivo.count).to eq(2)
    end
    it 'grava arquivos na hierarquia correta' do
      arquivos_params = [
        { nome: "Pasta 1", pasta: true, }, # id = 1
        { nome: "Pasta 2", pasta: true, diretorio: '1' }, # id = 2
        { nome: "Pasta 3", pasta: true, diretorio: '2' }, # id = 3
        { nome: "Arquivo 1", pasta: false, conteudo: @conteudo, diretorio: 1 }, # id = 4
        { nome: "Arquivo 2", pasta: false, conteudo: @conteudo, diretorio: 2 }, # id = 5
        { nome: "Arquivo 3", pasta: false, conteudo: @conteudo, diretorio: 2 }, # id = 6
        { nome: "Arquivo 4", pasta: false, conteudo: @conteudo, diretorio: 3 }, # id = 7
        { nome: "Arquivo 5", pasta: false, conteudo: @conteudo, diretorio: 3 }, # id = 8
      ]

      arquivos_params.each do |arquivo_params|
        @criar_arquivo_service.create(arquivo_params)
      end

      pasta1 = Arquivo.find(1)
      pasta2 = Arquivo.find(2)
      pasta3 = Arquivo.find(3)

      expect(pasta1.arquivos.count).to eq(2)
      expect(pasta2.arquivos.count).to eq(3)
      expect(pasta2.diretorio_id).to eq(1)
      expect(pasta3.arquivos.count).to eq(2)
      expect(pasta3.diretorio_id).to eq(2)
    end
    it 'não grava uma pasta inválida - com conteudo' do
      arquivo_params = { nome: "Teste", pasta: true, conteudo: @conteudo, diretorio: "" }
      @criar_arquivo_service.create(arquivo_params)

      expect(Arquivo.count).to eq(0)
    end
    it 'não grava um arquivo sem conteudo' do
      arquivo_params = { nome: "Teste", pasta: false, conteudo: '', diretorio: "" }
      @criar_arquivo_service.create(arquivo_params)

      expect(Arquivo.count).to eq(0)
    end
    it 'não grava um arquivo sem nome' do
      arquivo_params = { pasta: false, conteudo: @conteudo, diretorio: "" }
      @criar_arquivo_service.create(arquivo_params)

      expect(Arquivo.count).to eq(0)
    end
    it 'não grava um arquivo com diretorio inexistente' do
      arquivo_params = { nome: "Teste", pasta: false, conteudo: @conteudo, diretorio: "1" }

      expect { @criar_arquivo_service.create(arquivo_params) }.to raise_error(ActiveRecord::RecordNotFound)
      expect(Arquivo.count).to eq(0)
    end
  end
end
