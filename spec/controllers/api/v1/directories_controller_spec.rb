require 'rails_helper'

describe Api::V1::DirectoriesController, type: :controller do
  describe 'Creating a main directory without sub-directories' do
    let(:valid_params) { { name: 'Musics', format: :json } }

    before { post :create, params: valid_params }

    context 'When the parameters are valid' do
      let(:directory) { Directory.last }

      it { expect(response.status).to eq 200 }
      it { expect(directory.name).to eq 'Musics' }
      it { expect(directory.directory_id).to be_nil }
      it { expect(directory.directories.count).to eq 0 }
    end
  end
end