require 'rails_helper'

describe Api::V1::DirectoriesController, type: :controller do
  describe 'GET #index' do
    context 'when doesnt have directories' do
      before { get :index }

      it 'returns empty array' do
        expect(response.status).to eq(200)
        expect(response.body).to include_json(directories: [])
      end
    end

    context 'when have directory' do
      let!(:directory) { create(:directory) }
      before { get :index }

      it 'returns directory list' do
        expect(response.status).to eq(200)
        expect(response.body).to include_json(directories: [{ id: directory.id, name: directory.name }])
      end
    end
  end

  describe 'POST #create' do
    subject { post :create, params: { directory: directory_params } }

    context 'when have no ancestry' do
      let(:directory_params) { { name: 'Images' } }

      it 'creates the directory in root' do
        expect { subject }.to change(Directory, :count).by(1)
        expect(response.status).to eq(201)
        expect(response.body).to include_json(directory: { name: 'Images', ancestry: nil })
      end
    end

    context 'when have ancestry and parent exists' do
      let!(:parent) { create(:directory, name: 'root') }
      let(:directory_params) { { name: 'Images', parent_id: parent.id } }

      it 'creates the subdirectory in parent' do
        expect { subject }.to change(Directory, :count).by(1)
        expect(response.status).to eq(201)
        expect(response.body).to include_json(directory: { name: 'Images', ancestry: parent.id.to_s })
      end
    end

    context 'when have ancestry and parent doesnt exists' do
      let(:directory_params) { { name: 'Images', parent_id: 1 } }

      it 'raises error' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when directory name already exists' do
      let!(:directory) { create(:directory, name: 'Images') }
      let(:directory_params) { { name: 'Images' } }

      it 'returns 422' do
        subject
        expect(response.status).to eq(422)
        expect(response.body).to include_json(errors: { name: ['has already been taken'] })
      end
    end
  end

  describe 'PUT #update' do
    let!(:directory) { create(:directory, name: 'Audios') }
    subject { put :update, params: { id: directory.id, directory: directory_params } }

    context 'when directory doesnt exists with same name' do
      let(:directory_params) { { name: 'Images' } }

      it 'updates the directory' do
        expect { subject }.to change { directory.reload.name }.from('Audios').to('Images')
        expect(response.status).to eq(200)
        expect(response.body).to include_json(directory: { name: 'Images' })
      end
    end

    context 'when directory already exists' do
      let(:directory_params) { { name: 'Images' } }
      before { create(:directory, name: 'Images') }

      it 'doesnt updates the directory' do
        expect { subject }.to_not change { directory.reload.name }
        expect(response.status).to eq(422)
        expect(response.body).to include_json(errors: { name: ['has already been taken'] })
      end
    end

    context 'when updating parent' do
      let!(:parent) { create(:directory, name: 'Root') }
      let(:directory_params) { { name: 'Sounds', parent_id: parent.id } }

      it 'updates the directory' do
        expect { subject }.to change { directory.reload.name }.from('Audios').to('Sounds')
          .and change { directory.ancestry }.from(nil).to(parent.id.to_s)
        expect(response.status).to eq(200)
      end
    end
  end

  describe 'DELETE #destroy' do
    subject { delete :destroy, params: { id: directory_id } }

    context 'when directory exists' do
      let!(:directory) { create(:directory) }
      let(:directory_id) { directory.id }

      it 'deletes the directory' do
        expect { subject }.to change(Directory, :count).by(-1)
        expect { directory.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect(response.status).to eq(200)
      end
    end

    context 'when directory doesnt exists' do
      let(:directory_id) { 1 }

      it 'deletes the directory' do
        expect { subject }.to not_change(Directory, :count).and raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
