require 'rails_helper'

describe Api::V1::DirectoriesController, type: :controller do
  describe 'Main directory without sub-directories' do
    let(:valid_params) { { name: 'Musics', format: :json } }
    let(:invalid_params) { { name: '', format: :json } }

    context 'When the parameters are valid' do
      before { post :create, params: valid_params }
      let(:directory) { Directory.last }

      it { expect(response.status).to eq 200 }
      it { expect(directory.name).to eq 'Musics' }
      it { expect(directory.directory_id).to be_nil }
      it { expect(directory.directories.count).to eq 0 }
    end

    context 'When the parameters are invalid' do
      before { post :create, params: invalid_params }
      let(:directory) { Directory.last }

      it { expect(response.status).to eq 422 }
      it { expect(directory).to be_nil }
    end
  end

  describe 'Main directory with one sub-directory' do
    let(:main_directory) { FactoryBot.create(:directory, :main_directory) }
    let(:valid_params) { { name: 'Sub folder', directory_id: main_directory.id, format: :json } }

    context 'When the parameters are valid' do
      before { post :create, params: valid_params }
      let(:sub_directory) { main_directory.directories.first }

      it { expect(response.status).to eq 200 }
      it { expect(main_directory.directories.count).to eq 1 }
      it { expect(sub_directory.name).to eq 'Sub folder' }
      it { expect(sub_directory.directory.id).to eq main_directory.id }
    end
  end

  describe 'Main directory with two or more sub-directory' do
    let(:main_directory) { FactoryBot.create(:directory, :main_directory) }
    let(:first_valid_params) { { name: 'First Sub folder', directory_id: main_directory.id, format: :json } }
    let(:second_valid_params) { { name: 'Second Sub folder', directory_id: main_directory.id, format: :json } }

    context 'When the parameters are valid' do
      before do
        post :create, params: first_valid_params
        post :create, params: second_valid_params
      end
      let(:first_sub_directory) { main_directory.directories.first }
      let(:second_sub_directory) { main_directory.directories.last }


      it { expect(response.status).to eq 200 }
      it { expect(main_directory.directories.count).to eq 2 }
      it { expect(first_sub_directory.name).to eq 'First Sub folder' }
      it { expect(second_sub_directory.name).to eq 'Second Sub folder' }
      it { expect(first_sub_directory.directory.id).to eq main_directory.id }
      it { expect(second_sub_directory.directory.id).to eq main_directory.id }
    end
  end
end
