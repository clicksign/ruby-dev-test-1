require 'rails_helper'

RSpec.describe DocumentsController, type: :controller do
  let(:document) { build(:document, file: file, folder: folder) }
  let(:document_created) { create(:document, file: file, folder: folder) }
  let(:document_created2) { create(:document, file: file, folder: folder) }
  let(:folder) { create(:folder, user: user) }
  let(:user) { create(:user) }

  let(:valid_attributes) {
    { title: Faker::File.file_name, description: Faker::Lorem.sentence, file: file, folder_id: folder.id }
  }

  let(:update_attributes) {
    { title: Faker::File.file_name, description: Faker::Lorem.sentence, file: file, folder_id: folder.id }
  }

  let(:invalid_attributes) {
    { title: nil, description: nil, file: file, folder_id: folder.id }
  }

  let(:file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/files/file_mock.txt") }

  context 'validate parameters' do
    before do
      sign_in user
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Document' do
          expect { post :create, params: { document: valid_attributes } }
            .to change(Document, :count).by(1)
        end

        it 'redirects to the created document' do
          post :create, params: { document: valid_attributes }
          expect(response).to redirect_to "/folders/#{document.folder_id}"
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Document' do
          expect { post :create, params: { document: invalid_attributes } }
            .to change(Document, :count).by(0)
        end

        it 'returns unprocessable entity status code' do
          post :create, params: { document: invalid_attributes }
          expect(response.status).to eq(422)
        end
      end
    end

    describe 'PUT /update' do
      context 'with valid attributes' do
        it 'redirects to the folder path' do
          put :update, params: { id: document_created.id, document: update_attributes }
          expect(response).to redirect_to "/folders/#{folder.id}"
        end
      end

      context 'with invalid attributes' do
        it 'returns unprocessable entity status code' do
          put :update, params: { id: document_created.id, document: invalid_attributes }
          expect(response.status).to eq(422)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested document' do
        expect { delete :destroy, params: { id: document_created.id } }
          .to change(Document, :count).by(0)
      end

      it 'redirects to the folder path' do
        get :destroy, params: { id: document_created2 }
        expect(response).to redirect_to "/folders/#{folder.id}"
      end
    end
  end
end
