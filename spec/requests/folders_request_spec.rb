# frozen_string_literal: true

require 'rails_helper'

describe Api::FoldersController, type: :request do
  describe 'POST /api/folders' do
    context 'when folder does not exist' do
      let(:params) do
        {
          path: 'spec/fixtures/files/folder'
        }
      end

      it 'creates folder' do
        headers = { 'ACCEPT' => 'application/json' }
        expect{ post '/api/folders.json', params: params }.to change{ Folder.last }.to(
          have_attributes(name: File.basename(params[:path]), path: params[:path], parent_folder: be_present)
        )
      end
    end
    context 'when folder exists' do
      let(:params) do
        {
          path: 'spec/fixtures/files/folder'
        }
      end

      it 'does not create folder' do
        headers = { 'ACCEPT' => 'application/json' }
        post '/api/folders.json', params: params
        expect{ post '/api/folders.json', params: params }.not_to change{ Folder.count }
      end
    end
  end
  describe 'GET /api/folders.json' do
    context 'when folder exists' do
      let(:params) do
        {
          path: 'spec/fixtures/files/folder'
        }
      end
      let(:folder) { create(:folder) }

      it 'returns folders' do
        get '/api/folders.json', params: params
        expect(response).to have_http_status(:ok)
      end
    end
  end
  describe 'GET /api/folders/:id' do
    let(:folder) { create(:folder) }

    it 'returns folder' do
      get "/api/folders/#{folder.id}.json"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include(folder.name)
    end
  end
end