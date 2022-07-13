require 'rails_helper'

describe ArquivosController, type: :controller do
  before(:all) do
    @conteudo = Base64.encode64(File.open("#{Rails.root}/spec/support/attachments/image.png").read)
    criar_pastas_e_arquivos
  end
  it "lista todos os arquivos sem trazer subarquivos" do
    get :index, :params => { sub_pastas: false }
    total_arquivos_raiz = Arquivo.diretorios_raiz.count

    expect(response).to have_http_status(200)
    expect(response.content_type).to include("application/json")
    expect(total_arquivos_raiz).to eq(json.size)
  end
  it "lista todos os arquivos trazendo subarquivos" do
    get :index, :params => { sub_pastas: true }

    expect(response).to have_http_status(200)
    expect(response.content_type).to include("application/json")
    expect(@pasta1.arquivos.count).to eq(json[0]['arquivos'].size)
  end
  it "busca arquivo sem trazer subarquivos" do
    get :show, :params => { id: @pasta1.id }

    expect(response).to have_http_status(200)
    expect(response.content_type).to include("application/json")
    expect(@pasta1.id).to eq(json[0]['id'])
  end
  it "busca arquivo trazendo subarquivos" do
    get :show, :params => { id: @pasta1.id, sub_pastas: true }

    expect(response).to have_http_status(200)
    expect(response.content_type).to include("application/json")
    expect(@pasta1.id).to eq(json[0]['id'])
    expect(@pasta1.arquivos.count).to eq(json[0]['arquivos'].size)
  end
  it "retorna 404 ao buscar arquivo inexistente" do
    get :show, :params => { id: 99 }

    expect(response).to have_http_status(404)
    expect(response.content_type).to include("application/json")
  end
  it "cria arquivo" do
    total_arquivos = Arquivo.count
    arquivo_params = { nome: "Teste", pasta: false, conteudo: @conteudo, diretorio: "" }
    post :create, :params => arquivo_params

    expect(response).to have_http_status(201)
    expect(Arquivo.count).to eq(total_arquivos + 1)
  end
  it "altera arquivo" do
    total_arquivos_pasta_2 = @pasta2.arquivos.count
    update_params = { id: @pasta3.id, diretorio: @pasta2.id }
    put :update, :params => update_params

    expect(response).to have_http_status(201)
    expect(@pasta2.arquivos.count).to eq(total_arquivos_pasta_2 + 1)
  end
  it "deleta arquivo" do
    expect(Arquivo.count).to be(5)
    delete :destroy, :params => { id: @pasta1.id }
    expect(Arquivo.count).to be(0)
  end
  it "retorna 404 ao deleta arquivo inexistente" do
    delete :destroy, :params => { id: 99 }
    expect(response).to have_http_status(404)
  end
end

def criar_pastas_e_arquivos
  @pasta1 = create(:pasta_valida)
  @pasta2 = create(:pasta_valida, diretorio: @pasta1)
  @pasta3 = create(:pasta_valida, diretorio: @pasta1)

  @arquivo1 = create(:arquivo_valido, diretorio: @pasta2)
  @arquivo2 = create(:arquivo_valido, diretorio: @pasta3)
end
