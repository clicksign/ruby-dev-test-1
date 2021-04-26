require 'rails_helper'

describe Api::V1::DirectoriesController, type: :controller do
  describe 'Update directory entity' do
    let(:main_directory) { FactoryBot.create(:directory) }

    context 'When valid name param is passed' do
      let(:valid_name) { { id: main_directory.id, name: 'updated name', format: :json } }

      before { put :update, params: valid_name }

      it { expect(response.status).to eq 200 }
      it { expect(main_directory.reload.name).to eq 'updated name' }
      it { expect(assigns(:directory).persisted?).to be_truthy }
    end

    context 'When valid main directory ID is passed' do
      let(:subdirectory) { FactoryBot.create(:directory, directory: main_directory) }
      let(:second_main_directory) { FactoryBot.create(:directory) }
      let(:valid_subdirectory_attributes) { { id: subdirectory.id, directory_id: second_main_directory.id, format: :json } }

      before { put :update, params: valid_subdirectory_attributes }

      it { expect(response.status).to eq 200 }
      it { expect(subdirectory.reload.directory_id).to eq second_main_directory.id }
      it { expect(main_directory.directories.count).to eq 0 }
      it { expect(second_main_directory.directories.count).to eq 1 }
      it { expect(assigns(:directory).persisted?).to be_truthy }
    end
  end

  describe 'Update Directory entity' do
    let(:main_directory) { FactoryBot.create(:directory) }

    context 'When invalid name is passed' do
      let(:invalid_name) { { id: main_directory.id, name: '', format: :json } }

      before { put :update, params: invalid_name }

      it { expect(response.status).to eq 422 }
      it { expect(main_directory.reload.name).to eq main_directory.name }
      it { expect(assigns(:directory).persisted?).to be_truthy }
    end

    context 'When valid main directory ID is passed' do
      let(:subdirectory) { FactoryBot.create(:directory, directory: main_directory) }
      let(:invalid_subdirectory_attributes) { { id: subdirectory.id, directory_id: 12312, format: :json } }

      before { put :update, params: invalid_subdirectory_attributes }

      it { expect(response.status).to eq 422 }
      it { expect(subdirectory.reload.directory_id).to eq main_directory.id }
      it { expect(main_directory.directories.count).to eq 1 }
    end
  end
end