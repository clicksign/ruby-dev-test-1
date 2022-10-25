require 'rails_helper'

RSpec.describe FoldersController, type: :request do
  describe "POST .create" do
    it 'creates a new folder' do
      params = { folder: attributes_for(:folder) }

      expect do
        post folders_url(params)
      end.to change(Folder, :count).by(1)
    end

    describe 'POST .create' do
      specify do
        params = { folder: attributes_for(:folder, label: nil) }
        post folders_url(params)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
