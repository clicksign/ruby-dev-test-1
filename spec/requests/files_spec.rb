require 'rails_helper'

RSpec.describe 'Files', type: :request do
  describe 'GET folder files' do
    it 'returns http success' do
      folder = create(:folder)
      get folder_files_url(folder)
      expect(response).to have_http_status(:success)
    end

    it 'returns folder files' do
      folder = create(:folder)
      folder.files.attach(fixture_file_upload('image.png', 'image/png'))
      get folder_files_url(folder)
      expect(response.body).to have_json_size(1)
    end

    it 'returns 404 not existing folder' do
      get folder_files_url(99)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'Destroy file' do
    it 'returns http success' do
      folder = create(:folder)
      folder.files.attach(fixture_file_upload('image.png', 'image/png'))
      delete folder_file_url(folder, folder.files.first)
      expect(response).to have_http_status(:success)
    end

    it 'really delete file' do
      folder = create(:folder)
      folder.files.attach(fixture_file_upload('image.png', 'image/png'))
      delete folder_file_url(folder, folder.files.first)

      folder.reload
      expect(folder.files.size).to be_eql(0)
    end

    it 'returns 404 not existing folder' do
      folder = create(:folder)
      folder.files.attach(fixture_file_upload('image.png', 'image/png'))
      delete folder_file_url(folder, 99)
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'Create file' do
    it 'returns http success' do
      folder = create(:folder)
      post folder_files_url(folder), params: { file: fixture_file_upload('image.png', 'image/png') }
      expect(response).to have_http_status(:success)
    end

    it 'associate uploaded file to folder' do
      folder = create(:folder)
      post folder_files_url(folder), params: { file: fixture_file_upload('image.png', 'image/png') }
      folder.reload
      expect(folder.files.size).to be_eql(1)
    end

    it 'invalid folder id returns 404' do
      post folder_files_url(444), params: { file: fixture_file_upload('image.png', 'image/png') }
      expect(response).to have_http_status(:not_found)
    end
  end
end
