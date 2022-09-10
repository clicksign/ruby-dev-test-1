require 'rails_helper'

RSpec.describe FoldersController, type: :controller do
  let(:folder) { create(:folder, user: user) }
  let(:child_folder) { create(:folder, user: user, parent: folder) }
  let(:child_folder2) { create(:folder, user: user, parent: child_folder) }
  let(:user) { create(:user) }

  let(:valid_attributes) {
    { name: Faker::DcComics.hero, parent_id: folder.id }
  }

  let(:update_attributes) {
    { name: Faker::DcComics.hero, parent_id: folder.id }
  }

  let(:invalid_attributes) {
    { name: nil, parent_id: folder.id }
  }

  context 'with valid response' do
    before do
      sign_in user
    end

    describe 'GET /index' do
      it 'renders a successful response' do
        get :index
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        get :show, params: { id: folder.id }
        expect(response).to be_successful
      end
    end
  end

  context 'validate parameters' do
    before do
      sign_in user
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Folder' do
          expect { post :create, params: { folder: valid_attributes } }
            .to change(Folder, :count).by(2)
        end

        it 'redirects to the parent folder' do
          post :create, params: { folder: valid_attributes }
          expect(response).to redirect_to "/folders/#{folder.id}"
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Folder' do
          expect { post :create, params: { folder: invalid_attributes } }
            .to change(Folder, :count).by(1)
        end

        it 'returns unprocessable entity status code' do
          post :create, params: { folder: invalid_attributes }
          expect(response.status).to eq(422)
        end
      end
    end

    describe 'PUT /update' do
      context 'with valid attributes' do
        it 'redirects to the folder path' do
          put :update, params: { id: child_folder2, folder: update_attributes }
          expect(response).to redirect_to "/folders/#{folder.id}"
        end
      end

      context 'with invalid attributes' do
        it 'returns unprocessable entity status code' do
          put :update, params: { id: child_folder2, folder: invalid_attributes }
          expect(response.status).to eq(422)
        end
      end
    end

    describe 'DELETE /destroy' do
      it 'destroys the requested folder' do
        expect { delete :destroy, params: { id: child_folder2.id } }
          .to change(Folder, :count).by(2)
      end

      it 'redirects to the folder path' do
        get :destroy, params: { id: child_folder }

        expect(response).to redirect_to "/folders/#{folder.id}"
      end
    end
  end
end
