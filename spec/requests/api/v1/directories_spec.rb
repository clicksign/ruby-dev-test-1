require 'rails_helper'

RSpec.describe 'Directories', type: :request do
  describe 'GET #index' do
    it 'responds with ok' do
      get api_v1_directories_path, headers: headers_request
      expect(response.status).to eq(200)
    end

    context 'include new directoy' do
      let!(:folder) { create_list(:folder, 5) }

      it 'should returns all Directories' do
        get api_v1_directories_path, headers: headers_request
        expect(response_body_json.size).to eq(5)
      end
    end

    context 'include new directory with subdirectory' do
      let!(:directories) { create_list(:include_subs, 1) }

      it 'should returns all Directories' do
        get api_v1_directories_path, headers: headers_request
        expect(response_body_json.size).to eq(2)
      end
    end
  end

  describe 'POST #create' do
    let(:new_record_params) { { directory: attributes_for(:directory) }.to_json }
    it 'responds with ok' do
      post api_v1_directories_path, headers: headers_request, params: new_record_params
      expect(response.status).to eq(200)
    end

    it 'add a new Directory' do
      expect do
        post api_v1_directories_path, headers: headers_request, params: new_record_params
      end.to change(Directory, :count).by(1)
    end

    it 'add a another new Directory' do
      post api_v1_directories_path, headers: headers_request, params: new_record_params
      last_record = Directory.last
      expect(response_body_json['name']).to eq(last_record.name)
    end

    it 'add a folder with file' do
      folder = create(:folder)
      folder.files.attach(create_file_blob)
      expect(folder.files.any?).to eq(true)
      expect(folder.files.first.filename).to eq('img.png')
    end
  end

  describe 'GET #show' do
    let!(:folder) { create(:folder) }

    it 'responds with Ok' do
      get api_v1_directory_path(id: folder.id), headers: headers_request
      expect(response.status).to eq(200)
    end

    it 'should contains the same record data' do
      get api_v1_directory_path(id: folder.id), headers: headers_request
      expect(response.body).to eq(folder.to_json)
      expect(response_body_json['id']).to eq(folder.id)
    end
  end

  describe 'PATCH #update' do
    let!(:folder) { create(:folder) }
    let(:new_name) { 'Games' }
    let(:new_params) { { directory: { name: new_name } }.to_json }

    it 'responds with Ok' do
      patch api_v1_directory_path(id: folder.id), headers: headers_request, params: new_params
      expect(response.status).to eq(200)
    end

    it 'should updates Directory' do
      patch api_v1_directory_path(id: folder.id), headers: headers_request, params: new_params
      folder.reload
      expect(folder.name).to eq(new_name)
    end
  end

  describe 'DELETE #destroy' do
    let!(:folder) { create(:folder) }

    it 'responds success with no_content' do
      delete api_v1_directory_path(id: folder.id), headers: headers_request
      expect(response.status).to eq(204)
      expect(response).to have_http_status(:no_content)
    end
  end
end
