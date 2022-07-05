# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'folders', type: :request do
  context 'when POST /folders' do
    context 'when create new folder without parent' do
      it 'returns successfully' do
        expect do
          post '/folders', params: attributes_for(:folder)
        end.to change(FolderRecord, :count)

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(body.symbolize_keys!).to include(
          name: be_an(String),
          folder_id: anything,
          id: be_an(Integer)
        )
      end
    end

    context 'when send invalid folder' do
      it do
        post '/folders', params: attributes_for(:folder, name: nil)

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(body.symbolize_keys!).to include(
          errors: anything
        )
      end
    end
  end

  context 'when PUT /folders/:id' do
    let(:folder) { create(:folder) }

    context 'when update folder successfully' do
      it do
        expect do
          put "/folders/#{folder.id}", params: attributes_for(:folder)
          folder.reload
        end.to change(folder, :name)
        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(body.symbolize_keys!).to include(
          name: be_an(String),
          folder_id: nil,
          id: be_an(Integer)
        )
      end
    end

    context 'when send invalid params' do
      it do
        put "/folders/#{folder.id}", params: attributes_for(:folder, name: nil)

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(body.symbolize_keys!).to include(
          errors: anything
        )
      end
    end

    context 'when folder not exists' do
      it do
        put '/folders/0', params: attributes_for(:folder, name: nil)

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(body.symbolize_keys!).to include(
          error: be_an(String),
          message: be_an(String)
        )
      end
    end
  end

  context 'when DELETE /folders/:id' do
    let(:folder) { create(:folder) }

    context 'when delete folder successfully' do
      it do
        expect do
          delete "/folders/#{folder.id}"
        end.to change(FolderRecord, :count).by(0)

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when folder not exists' do
      it do
        delete '/folders/0'

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(body.symbolize_keys!).to include(
          error: be_an(String),
          message: be_an(String)
        )
      end
    end
  end

  context 'when GET /folders/:id' do
    let(:folder) { create(:folder) }

    context 'when returns folder details successfully' do
      it do
        get "/folders/#{folder.id}"

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(body.symbolize_keys!).to include(
          name: be_an(String),
          folder_id: nil,
          id: be_an(Integer)
        )
      end
    end

    context 'when folder not exists' do
      it do
        get '/folders/0'

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(body.symbolize_keys!).to include(
          error: be_an(String),
          message: be_an(String)
        )
      end
    end
  end

  context 'when GET /folders/:folder_id/childrens' do
    let(:folder) { create(:folder) }

    context 'when returns childrens of folder successfully' do
      before do
        create_list(:folder, 5, folder_id: folder.id)
      end

      it do
        get "/folders/#{folder.id}/childrens"

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(body).to be_a_kind_of(Array)
        expect(body.map(&:symbolize_keys!)).to include(include(
                                                         id: be_an(Integer),
                                                         name: be_an(String),
                                                         folder_id: be_an(Integer)
                                                       ))
      end
    end
  end

  context 'when GET /folders' do
    let(:folder) { create(:folder) }

    context 'when returns parent folders successfully' do
      before do
        create_list(:folder, 5, folder_id: folder.id)
      end

      it do
        get '/folders'

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(body).to be_a_kind_of(Array)
        expect(body.length).to eq(1)
        expect(body.map(&:symbolize_keys!)).to include(include(
                                                         id: be_an(Integer),
                                                         name: be_an(String),
                                                         folder_id: nil
                                                       ))
      end
    end
  end
end
