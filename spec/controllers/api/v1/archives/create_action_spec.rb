require 'rails_helper'

describe Api::V1::ArchivesController, type: :controller do
  describe 'Archive for a directory' do
    let(:directory) { FactoryBot.create(:directory) }
    let(:valid_params) { { name: 'pic1', directory_id: directory.id, format: :json } }
    let(:invalid_params) { { name: '', directory_id: directory.id, format: :json } }

    context 'When the parameters are valid' do
      before { post :create, params: valid_params }
      let(:archive) { Archive.first }

      it { expect(response.status).to eq 200 }
      it { expect(archive.name).to eq 'pic1' }
      it { expect(archive.directory.id).to eq directory.id }
    end

    context 'When the parameters are invalid' do
      before { post :create, params: invalid_params }
      let(:archive) { Archive.last }

      it { expect(response.status).to eq 422 }
      it { expect(archive).to be_nil }
    end

    context 'When directory doenst exist' do
      let(:invalid_params) { { name: 'pic2', directory_id: 123, format: :json } }
      before { post :create, params: invalid_params }
      let(:archive) { Archive.last }

      it { expect(response.status).to eq 422 }
      it { expect(archive).to be_nil }
    end
  end
end