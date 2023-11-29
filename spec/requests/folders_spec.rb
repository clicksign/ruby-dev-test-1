require 'rails_helper'

RSpec.describe "Folders", type: :request do
  headers = { "ACCEPT" => "application/json" }

  let(:root_folder) { FactoryBot.create(:folder) }
  let(:folder_id) { root_folder.id }
  let(:child_folder) { FactoryBot.create(:folder, parent_id: root_folder.id) }
  let(:older_name) { root_folder.name }

  describe "GET /folders" do
    subject(:request) { get "/folders", headers: headers }
    
    context 'when exist two folders' do
      before do
        root_folder
        child_folder
        request 
      end

      it '', :aggregate_failures do
        expect(JSON.parse(response.body).count).to eq(2)
        expect(response).to have_http_status(:ok)
      end
    end

    it 'when not exist folders', :aggregate_failures do
      request

      expect(JSON.parse(response.body)).to match_array([])
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /folders" do
    subject(:request) { post "/folders", params: { folder: { name: } }, headers: headers }
    before { request }

    context 'when name is valid' do
      let(:name) { Faker::Name.name }

      it do
        expect(response).to have_http_status(:created)
      end
    end

    context 'when name is invalid' do
      let(:name) { "" }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT /folders/:folder_id" do
    subject(:request) { put "/folders/#{folder_id}", params: { folder: { name: } }, headers: headers }
    before { request }

    context 'when folder exist' do
      let(:folder_id) { root_folder.id }
      let(:name) { Faker::Name.name }

      it '', :aggregate_failures do
        old_name = root_folder.name

        expect(root_folder.reload.name).not_to eq(old_name)
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when name is invalid' do
      let(:folder_id) { root_folder.id }
      let(:name) { '' }

      it do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context 'when folder not found' do
      let(:folder_id) { 0 }
      let(:name) { Faker::Name.name }

      it do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "SHOW /folders/:folder_id" do
    subject(:request) { get "/folders/#{folder_id}", headers: headers }
    before { request }

    context 'when folder exists' do
      let(:folder_id) { root_folder.id }

      it do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when folder not exists' do
      let(:folder_id) { 0 }

      it do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE /folders/:folder_id/" do
    subject(:request) { delete "/folders/#{folder_id}", headers: headers }
    before do
      root_folder
      folder_id
      request
    end

    context 'when folder successfully deleted' do
      it do
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when folder not found' do
      let(:folder_id) { 0 }
      it do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end