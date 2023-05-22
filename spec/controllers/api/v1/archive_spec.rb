require 'rails_helper'

RSpec.describe 'Archive', type: :request do
  before do
    @folder = Folder.create(name: 'Folder 1')
    @archive = Archive.create(name: 'Archive 1', folder_id: @folder.id)
  end
  context 'create' do
    context 'when success' do
      it 'return status 201' do
        params = { name: 'Archive X', folder_id: @folder.id }

        post '/api/v1/archives', params: params

        expect(response.status).to eq 201
        expect(JSON.parse(response.body)['name']).to eq 'Archive X'
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { folder_id: nil }

        post '/api/v1/archives', params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['folder']).to eq ['must exist']
      end
    end
  end
  context 'delete' do
    context 'when success' do
      it 'return status 200' do
        params = { archive_id: @archive.id }

        delete "/api/v1/archives/#{@archive.id}", params: params

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['deleted']).to eq @archive.id
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { folder_id: 'Archive X' }

        delete "/api/v1/archives/#{@archive.id}", params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq nil
      end
    end
  end
  context 'select' do
    context 'when success' do
      it 'return status 200' do
        get "/api/v1/archives/#{@archive.id}"

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['name']).to eq 'Archive 1'
      end
    end
    context 'when failure' do
      it 'return status 422' do
        get '/api/v1/archives/999999'

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)).to eq []
      end
    end
  end
  context 'update' do
    context 'when success' do
      it 'return status 200' do
        params = { name: 'Archive X1' }

        patch "/api/v1/archives/#{@archive.id}", params: params

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['name']).to eq 'Archive X1'
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { folder_id: nil }

        patch "/api/v1/archives/#{@archive.id}", params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['folder']).to eq ['must exist']
      end
    end
  end
end
