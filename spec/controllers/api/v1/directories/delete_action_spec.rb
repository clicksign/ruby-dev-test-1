require 'rails_helper'

describe Api::V1::DirectoriesController, type: :controller do
  describe 'Delete main directory entity' do
    let(:main_directory) { FactoryBot.create(:directory) }
    let(:subdirectory) { FactoryBot.create(:directory, directory_id: main_directory.id) }

    context 'when have subdirectories' do
      let(:valid_params) { { id: main_directory.id, format: :json } }

      before do
        delete :destroy, params: valid_params
      end

      it { expect(Directory.find_by(id: main_directory.id)).to be_nil }
      it { expect(Directory.all.first).to be_nil }
    end
  end
end