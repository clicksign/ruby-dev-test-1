require 'rails_helper'

RSpec.describe "Documents", type: :request do
  headers = { "ACCEPT" => "application/json" }
  
  let(:document) { FactoryBot.create(:document) }
  let(:folder_id) { document.folder_id }
  let(:document_id) { document.id }
  let(:name) { Faker::Name.name }
  let(:file) { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'files', 'image.png')) }

  describe "GET /documents" do
    subject(:request) { get "/folders/:folder_id/documents", headers: headers }

    context 'when exists one document', :aggregate_failures do
      before do
        document
        request 
      end

      it do 
        expect(JSON.parse(response.body).count).to eq(1)
        expect(response).to have_http_status(:ok)
      end
    end

    it 'when not exist documents', :aggregate_failures do
      request

      expect(JSON.parse(response.body)).to match_array([])
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /folders/:folder_id/documents" do
    subject(:request) { post "/folders/#{folder_id}/documents", params: { document: { name:, file: } }, headers: headers }
    before { request }

    context 'when document is valid' do
      let(:folder_id) { FactoryBot.create(:folder).id }
      it do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when name and file are invalid' do
      let(:folder_id) { FactoryBot.create(:folder).id }
      let(:name) { "" }
      let(:file) { "" }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /folders/:folder_id/documents/:document_id" do
    subject(:request) { put "/folders/#{folder_id}/documents/#{document_id}", params: { document: { name:, file: } }, headers: headers }
    before do
      document
      folder_id
      document_id
      request 
    end

    context 'when document exist' do
      it '', :aggregate_failures do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when name is invalid' do
      let(:name) { '' }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when document not found' do
      let(:document_id) { 0 }

      it do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "SHOW /folders/:folder_id/documents/:document_id" do
    subject(:request) { get "/folders/#{folder_id}/documents/#{document_id}", headers: headers }
    before do
      document
      folder_id
      document_id
      request 
    end

    context 'when document exists' do
      it do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when document not exists' do
      let(:document_id) { 0 }

      it do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE /folders/:folder_id/documents/:document_id" do
    subject(:request) { delete "/folders/#{folder_id}/documents/#{document_id}", headers: headers }
    before do
      document
      folder_id
      document_id
      request
    end

    context 'when document successfully deleted' do
      it do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when document not found' do
      let(:document_id) { 0 }
      it do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
