# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'folders', type: :request do
  context 'POST /folders' do
    context 'when create new folder without parent' do
      it 'returns successfully' do
        post '/folders', params: { folder: attributes_for(:folder) }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(body.symbolize_keys!).to include(
          name: be_an(String),
          folder_id: anything,
          file_items: be_an(Array),
          childrens: be_an(Array),
          id: be_an(Integer)
        )
      end
    end

    context 'when send invalid input' do
      it do
        post '/folders', params: { folder: attributes_for(:folder, name: nil) }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(body.symbolize_keys!).to include(
          errors: anything
        )
      end
    end
  end

  context 'PUT /folders/:id' do
    let(:folder) { create(:folder) }

    context 'when update folder successfully' do
      it do
        put "/folders/#{folder.id}", params: { folder: attributes_for(:folder) }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
        expect(body.symbolize_keys!).to include(
          name: be_an(String),
          folder_id: nil,
          file_items: be_an(Array),
          childrens: be_an(Array),
          id: be_an(Integer)
        )
      end
    end

    context 'when send invalid params' do
      it do
        put "/folders/#{folder.id}", params: { folder: attributes_for(:folder, name: nil) }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(body.symbolize_keys!).to include(
          errors: anything
        )
      end
    end

    context 'when folder not exists' do
      it do
        put '/folders/0', params: { folder: attributes_for(:folder, name: nil) }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:not_found)
        expect(body.symbolize_keys!).to include(
          error: be_an(String),
          message: be_an(String)
        )
      end
    end
  end
end
