# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'folders', type: :request do
  context 'when create new folder without parent' do
    it 'returns successfully' do
      post '/folders', params: { folder: attributes_for(:folder) }

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(body.symbolize_keys!).to include(
        name: be_an(String),
        folder_id: nil,
        file_items: be_an(Array),
        childrens: be_an(Array),
        id: be_an(Integer)
      )
    end
  end

  context 'when create new folder with parent' do
    let(:folder) { create(:folder) }

    it 'returns successfully' do
      post '/folders', params: { folder: attributes_for(:folder, folder_id: folder.id) }

      body = JSON.parse(response.body)
      expect(response).to have_http_status(:created)
      expect(body.symbolize_keys!).to include(
        name: be_an(String),
        folder_id: be_an(Integer),
        file_items: be_an(Array),
        childrens: be_an(Array),
        id: be_an(Integer)
      )
    end
  end
end
