require 'rails_helper'

RSpec.describe 'Folder', type: :request do
  before do
    @folder = Folder.create(name: 'Folder 1')
  end
  context 'create' do
    context 'when success' do
      it 'return status 201' do
        params = { name: 'Folder X' }

        post '/api/v1/folders', params: params

        expect(response.status).to eq 201
        expect(JSON.parse(response.body)['name']).to eq 'Folder X'
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { name: nil }

        post '/api/v1/folders', params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['name']).to eq ["can't be blank"]
      end
    end
  end
  context 'delete' do
    context 'when success' do
      it 'return status 200' do
        params = { folder_id: @folder.id }

        delete "/api/v1/folders/#{@folder.id}", params: params

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['deleted']).to eq @folder.id
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { folder_id: 'Folder X' }

        delete "/api/v1/folders/#{@folder.id}", params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['errors']).to eq nil
      end
    end
  end
  context 'select' do
    context 'when success' do
      it 'return status 200' do
        get "/api/v1/folders/#{@folder.id}"

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['name']).to eq 'Folder 1'
      end
    end
    context 'when failure' do
      it 'return status 422' do
        get '/api/v1/folders/999999'

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)).to eq []
      end
    end
  end
  context 'update' do
    context 'when success' do
      it 'return status 200' do
        params = { name: 'Folder X1' }

        patch "/api/v1/folders/#{@folder.id}", params: params

        expect(response.status).to eq 200
        expect(JSON.parse(response.body)['name']).to eq 'Folder X1'
      end
    end
    context 'when failure' do
      it 'return status 422' do
        params = { name: nil }

        patch "/api/v1/folders/#{@folder.id}", params: params

        expect(response.status).to eq 422
        expect(JSON.parse(response.body)['name']).to eq ["can't be blank"]
      end
    end
  end
end
