require 'rails_helper'

RSpec.describe 'Folders', type: :request do
  describe 'GET index' do
    it 'returns http success' do
      get '/folders'
      expect(response).to have_http_status(:success)
    end
    it 'returns right response structure' do
      folder1 = create(:folder, name: 'C')
      folder2 = create(:folder, name: 'A')
      folder3 = create(:folder, parent_id: folder1.id)
      folder1.files.attach(fixture_file_upload('image.png', 'image/png'))
      file1 = folder1.files.first
      folders = [
        { id: folder2.id, name: folder2.name, children: [], files: [] },
        { id: folder1.id, name: folder1.name, children: [{ id: folder3.id, name: folder3.name }], files: [] }
      ]
      get '/folders'
      expect(response).to have_http_status(:success)
      expect(response.body).to have_json_size(2)
      expect(normalize_json(response.body)).to be_json_eql(normalize_json(folders.to_json)).excluding('files')
      expect(response.body).to have_json_path('1/files/0')
    end
  end

  describe 'POST create' do
    it 'returns http success' do
      post '/folders', params: { folder: { name: 'A' } }
      expect(response).to have_http_status(:success)
    end

    it 'create folder success' do
      expect do
        post '/folders', params: { folder: { name: 'A' } }
      end.to change(Folder, :count).by(1)
    end

    it 'create folder with parent success ' do
      folder1 = create(:folder)
      expect do
        post '/folders', params: { folder: { name: 'A', parent_id: folder1.id } }
      end.to change(Folder, :count).by(1)
      expect(response).to have_http_status(:success)
    end

    it 'invalid parameter name returns :unprocessable_entity' do
      post '/folders', params: { folder: { foo: :bar } }
      expect(response).to have_http_status(:unprocessable_entity)
    end

    it 'invalid parameter parent_id returns :unprocessable_entity' do
      post '/folders', params: { folder: { name: 'A', parent_id: 1 } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PATCH update' do
    context 'with valid parameters' do
      it 'returns http success' do
        folder = create(:folder)
        put folder_url(folder), params: { folder: { name: Faker.name } }
        expect(response).to have_http_status(:success)
      end

      it 'updates the requested folder name' do
        folder = create(:folder)
        new_name = Faker.name
        put folder_url(folder), params: { folder: { name: new_name } }
        folder.reload
        expect(folder.name).to eq(new_name)
      end

      it 'updates the requested folder parent' do
        folder = create(:folder)
        folder2 = create(:folder)
        put folder_url(folder), params: { folder: { parent_id: folder2.id } }
        folder.reload
        expect(folder.parent_id).to eq(folder2.id)
      end
    end

    context 'with invalid parameters' do
      it 'returns http 400 without params' do
        folder = create(:folder)
        put folder_url(folder)
        expect(response).to have_http_status(:bad_request)
      end

      it 'not allow nil name' do
        folder = create(:folder)
        put folder_url(folder), params: { folder: { name: nil } }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'not allow move to children' do
        folder = create(:folder)
        folder2 = create(:folder, parent_id: folder.id)
        put folder_url(folder), params: { folder: { parent_id: folder2.id } }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'GET show' do
    it 'returns http success' do
      folder = create(:folder)
      get folder_url(folder)
      expect(response).to have_http_status(:success)
    end

    it 'returns 404 on non existing' do
      get '/folders/99'
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'DELETE destroy' do
    it 'returns http success' do
      folder = create(:folder)
      delete folder_url(folder)
      expect(response).to have_http_status(:success)
    end

    it 'delete register' do
      folder = create(:folder)
      expect { delete folder_url(folder) }.to change(Folder, :count).by(-1)
    end

    it 'delete sub folders' do
      folder = create(:folder)
      folder2 = create(:folder, parent_id: folder.id)
      expect { delete folder_url(folder) }.to change(Folder, :count).by(-2)
    end

    it 'returns 404 on non existing' do
      get '/folders/99'
      expect(response).to have_http_status(:not_found)
    end
  end
end
