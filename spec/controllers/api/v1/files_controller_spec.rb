require 'rails_helper'

RSpec.describe Api::V1::FilesController, type: :controller do
  describe 'GET #index' do
    subject { get :index, params: { directory_id: directory_id } }

    context 'when directory have files' do
      let(:file_1) { fixture_file_upload('sample.jpg') }
      let(:file_2) { fixture_file_upload('sample.mp3') }

      let!(:directory) { create(:directory, files: [file_1, file_2]) }
      let(:directory_id) { directory.id }

      it 'shows list of files' do
        subject

        expect(response).to have_http_status(:ok)
        json_body = JSON.parse(response.body)

        expect(json_body['data'][0]['attributes']).to include('filename' => file_1.original_filename)
        expect(json_body['data'][0]['attributes']).to include('byte_size' => file_1.size)
        expect(json_body['data'][0]['attributes']).to include('content_type' => 'image/jpeg')

        expect(json_body['data'][1]['attributes']).to include('filename' => file_2.original_filename)
        expect(json_body['data'][1]['attributes']).to include('byte_size' => file_2.size)
        expect(json_body['data'][1]['attributes']).to include('content_type' => 'audio/mpeg')
      end
    end

    context 'when directory is empty' do
      let!(:directory) { create(:directory) }
      let(:directory_id) { directory.id }

      it 'show empty data' do
        subject

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq '{"data":[]}'
      end
    end

    context 'when directory doesnt exists' do
      let(:directory_id) { 998_899 }

      it 'raises error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }
    let!(:directory) { create(:directory, parent_id: 1) }

    let(:file) { fixture_file_upload('sample.jpg') }
    let(:params) { { directory_id: directory_id, file: [file] } }

    context 'when uploading file to existent directory' do
      let(:directory_id) { directory.id }

      it 'uploads the file' do
        expect { subject }.to change(directory.files, :count).by(1)

        expect(response).to have_http_status(:created)

        json_body = JSON.parse(response.body)
        expect(json_body['data']['attributes']).to include('filename' => file.original_filename)
        expect(json_body['data']['attributes']).to include('byte_size' => file.size)
        expect(json_body['data']['attributes']).to include('content_type' => 'image/jpeg')
        expect(json_body['data']['links']).to include(
          'file_url' => Rails.application.routes.url_helpers.rails_blob_url(directory.files.last)
        )
      end
    end

    context 'when uploading file to non existent directory' do
      let(:directory_id) { 99_999 }

      it 'raises error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:directory) { create(:directory, :with_files) }

    subject { delete :destroy, params: { id: file_id, directory_id: directory_id } }

    context 'when deleting from existent directory' do
      let(:file) { directory.files.last }
      let(:file_id) { file.id }
      let(:directory_id) { directory.id }

      it 'deletes the file' do
        expect { subject }.to change(directory.files, :count).by(-1)

        expect(response).to have_http_status(:ok)
        json_body = JSON.parse(response.body)

        expect(json_body['data']['attributes']).to include('filename' => file.filename)
        expect(json_body['data']['attributes']).to include('byte_size' => file.byte_size)
        expect(json_body['data']['attributes']).to include('content_type' => file.content_type)
      end
    end
  end
end
