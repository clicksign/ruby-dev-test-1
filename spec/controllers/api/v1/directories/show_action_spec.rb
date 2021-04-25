require 'rails_helper'

describe Api::V1::DirectoriesController, type: :controller do
  describe 'Show directory entity' do
    let(:directory) { FactoryBot.create(:directory) }
    let(:invalid_params) { { id: 999, format: :json } }
    let(:valid_params) { { id: directory.id, format: :json } }

    context 'when directory is valid' do
      before { get :show, params: valid_params } 

      it { expect(response.status).to eq 200 }
      it { expect(assigns(:directory)).to eq directory }
    end

    context 'when directory is invalid' do
      before { get :show, params: invalid_params } 

      it { expect(response.status).to eq 204 }
    end
  end
end