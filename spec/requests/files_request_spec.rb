# frozen_string_literal: true

require 'rails_helper'

describe Api::FilesController, type: :request do
  describe 'POST /api/files' do
    let(:params) do
      {
        type: 'local',
        path: 'spec/fixtures/files/file.txt',
        data: 'This is a test file'
      }
    end

    context 'when file does not exist' do
      before do
        allow(Base64).to receive(:strict_decode64).and_return('decoded_file')
      end

      it 'creates file' do
        headers = { 'ACCEPT' => 'application/json' }
        expect{ post '/api/files.json', params: params }.to change{ File::Local.last }.to(
          have_attributes(
            name: 'file.txt',
            file_data: nil,
            attachment: have_attributes(service_name: 'local')
          )
        )
      end
    end
    context 'when given invalid params' do
      it 'returns error' do
        post '/api/files.json', params: {type: 'invalid'}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET /api/files.json' do
    let(:params) do
      {
        name: 'file.txt'
      }
    end

    context 'when file exists' do
      it 'returns files' do
        create(:storage, name: 'file.txt')
        get '/api/files.json', params: params
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('file.txt')
      end
    end

    context 'when file does not exist' do
      it 'returns empty array' do
        get '/api/files.json', params: {folder: 'spec/fixtures/invalid'}
        expect(response).to have_http_status(:ok)
        expect(response.body).to eq('[]')
      end
    end
  end

  describe 'GET /api/files/:id' do
    let(:file) { create(:storage) }

    context 'when file exists' do
      it 'returns file' do
        get "/api/files/#{file.id}.json"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include(file.name)
      end
    end

    context 'when file does not exist' do
      it 'returns empty array' do
        get '/api/files/0'
        expect(response).to have_http_status(:not_found)
        expect(response.body).to include('File not found')
      end
    end
  end
end