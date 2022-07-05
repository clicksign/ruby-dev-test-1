# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'file_items', type: :request do
  context 'when POST /folders/:id/file_items' do
    let(:folder) { create(:folder) }
    let(:content) { blob_file(Rails.root.join('db/files/postgres.png'), 'postgres.png', 'image/png') }

    context 'when create new file item' do
      let(:params) do
        attributes_for(:file_item, content: content)
      end

      it 'returns successfully' do
        post "/folders/#{folder.id}/file_items", params: params

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:created)
        expect(body.symbolize_keys!).to include(
          name: be_an(String),
          folder_id: be_an(Integer),
          content: be_an(String)
        )
      end
    end

    context 'when folder_id not exists' do
      let(:params) do
        attributes_for(:file_item, content: content)
      end

      it 'returns successfully' do
        post '/folders/0/file_items', params: params

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(body.symbolize_keys!).to include(
          error: be_an(String),
          message: be_an(String)
        )
      end
    end
  end
end
