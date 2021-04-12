require 'rails_helper'

describe Api::V1::FilesController, type: :controller do
  let!(:directory) { create(:directory) }
  let!(:directory_id) { directory.id }

  describe 'GET #index' do
    subject { get :index, params: { directory_id: directory_id } }

    context 'when directory exists and there is a file' do
      let!(:directory) { create(:directory, :with_file) }
      before { subject }

      it 'returns file list' do
        expect(response.status).to eq(200)
        expect(response.body).to include_json([
          id: directory.files.first.id,
          filename: 'sample.txt',
          content_type: 'text/plain'
        ])
      end
    end

    context 'when directory exists but there is no files' do
      before { subject }

      it 'returns empty' do
        expect(response.status).to eq(200)
        expect(response.body).to eq('[]')
      end
    end

    context 'when directory doesnt exists' do
      let(:directory_id) { 0 }

      it 'raises error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'POST #create' do
    let!(:file) { fixture_file_upload('sample.txt', 'text/plain') }
    subject { post :create, params: { directory_id: directory_id, file: [file] } }

    context 'when directory exists' do
      let(:directory_id) { directory.id }

      it 'uploads the file' do
        expect { subject }.to change(directory.files, :count).by(1)
        expect(response.status).to eq(201)
        expect(response.body).to include_json([
          {
            id: directory.files.first.id,
            filename: 'sample.txt',
            content_type: 'text/plain'
          }
        ])
      end
    end

    context 'when directory doesnt exists' do
      let(:directory_id) { 0 }

      it 'raises error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { directory_id: directory_id, id: file_id } }

    context 'when directory exists' do
      let!(:directory) { create(:directory, :with_file) }
      let!(:file) { directory.files.last }
      let(:directory_id) { directory.id }
      let(:file_id) { file.id }

      it 'deletes the file' do
        expect { subject }.to change { directory.reload.files.count }.by(-1)
        expect(response.body).to include_json(id: file.id, filename: 'sample.txt', content_type: 'text/plain')
      end
    end

    context 'when directory doesnt exists' do
      let(:directory_id) { 0 }
      let(:file_id) { 1 }

      it 'raises error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
