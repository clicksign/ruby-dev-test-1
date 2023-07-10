require 'rails_helper'

RSpec.describe Api::V1::FoldersController, type: :request do
  let(:valid_attributes) do
    { folder: build(:folder).attributes.slice('name') }
  end

  let(:invalid_attributes) do
    {
      folder: build(:folder, name: nil).attributes.slice('name')
    }
  end

  let!(:folder) { create(:folder) }

  let(:response_json) { JSON.parse response.body }

  describe 'GET /index' do
    it 'renders a successful response' do
      get api_v1_folders_url, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      get api_v1_folder_url(folder), as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Folder' do
        expect {
          post api_v1_folders_url, params: valid_attributes, as: :json
        }.to change(Folder, :count).by(1)
      end

      context 'renders a JSON response with the new folder' do
        let(:min_keys_expected) do
          %w[id name main_folder_id created_at updated_at full_path archives]
        end

        before do
          post api_v1_folders_url, params: valid_attributes, as: :json
        end

        it { expect(response).to have_http_status(:created) }
        it { expect(response.content_type).to match(a_string_including('application/json')) }
        it { expect(response_json.keys).to match_array(min_keys_expected) }

        context 'with nested_attributes' do
          let(:valid_attributes) do
            {
              folder: {
                name: 'Level 1',
                sub_folders_attributes: [
                  {
                    name: 'Level 2',
                    archives_attributes: build_list(:archive, 1)
                  }
                ]
              }
            }

            it { expect(response).to have_http_status(:created) }
            it { expect(response_json['archives']).not_to be_empty }
            it 'has created all folders' do
              expect {
                post api_v1_folders_url, params: valid_attributes, as: :json
              }.to change(Folder, :count).by(2)
            end

            it 'has created all archives' do
              expect {
                post api_v1_folders_url, params: valid_attributes, as: :json
              }.to change(Archive, :count).by(1)
            end
          end
        end
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Folder' do
        expect {
          post api_v1_folders_url, params: invalid_attributes, as: :json
        }.to change(Folder, :count).by(0)
      end

      context 'renders a JSON response with errors for the new folder' do
        before do
          post api_v1_folders_url, params: invalid_attributes, as: :json
        end

        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(response.content_type).to match(a_string_including('application/json')) }
        it { expect(response_json.keys).to match_array(['name']) }
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_name) { 'New Name Folder' }
      let(:new_attributes) do
        { folder: { name: new_name } }
      end

      before do
        patch api_v1_folder_url(folder), params: new_attributes, as: :json
      end

      it { expect(folder.reload.name).to eq(new_name) }

      context 'renders a JSON response with the folder' do
        it { expect(response).to have_http_status(:ok) }
        it { expect(response.content_type).to match(a_string_including('application/json')) }

        it 'with correct new name in response' do
          expect(response_json['name']).to eq(new_name)
        end
      end
    end

    context 'with invalid parameters' do
      before do
        patch api_v1_folder_url(folder), params: { folder: { name: nil } }, as: :json
      end

      context 'renders a JSON response with errors for the folder' do
        it { expect(response).to have_http_status(:unprocessable_entity) }
        it { expect(response.content_type).to match(a_string_including('application/json')) }
      end
    end
  end

  describe 'DELETE /destroy' do
    context 'destroys the requested folder' do
      it 'with correct http_status' do
        delete api_v1_folder_url(folder), as: :json

        expect(response).to have_http_status(:no_content)
      end

      it 'with deleted' do
        expect {
          delete api_v1_folder_url(folder), as: :json
        }.to change(Folder, :count).by(-1)
      end
    end
  end
end
