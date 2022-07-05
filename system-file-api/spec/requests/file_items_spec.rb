# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'file_items', type: :request do
  context 'when POST /folders/:folder_id/file_items' do
    let(:folder) { create(:folder) }
    let(:content) { blob_file(Rails.root.join('db/files/githubactions.png'), 'githubactions.png', 'image/png') }

    context 'when create new file item' do
      let(:params) do
        attributes_for(:file_item, content: content)
      end

      it 'returns successfully' do
        expect do
          post "/folders/#{folder.id}/file_items", params: params
        end.to change(FolderRecord, :count)

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

  context 'when PUT /folders/:folder_id/file_items/:id' do
    let(:folder) { create(:folder) }
    let(:content) { blob_file(Rails.root.join('db/files/githubactions.png'), 'githubactions.png', 'image/png') }
    let(:file_item) { create(:file_item, folder: folder) }

    context 'when update file item' do
      let(:params) do
        attributes_for(:file_item, name: 'New Name', content: content)
      end

      it 'returns successfully' do
        expect do
          put "/folders/#{folder.id}/file_items/#{file_item.id}", params: params
          file_item.reload
        end.to change(file_item, :name)
          .and change { file_item.content.key }

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:ok)
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
        put "/folders/0/file_items/#{file_item.id}", params: params

        body = JSON.parse(response.body)
        expect(response).to have_http_status(:unprocessable_entity)
        expect(body.symbolize_keys!).to include(
          error: be_an(String),
          message: be_an(String)
        )
      end
    end
  end

  context 'when DELETE /folders/:folder_id/file_items/:id' do
    let(:folder) { create(:folder) }
    let(:file_item) { create(:file_item, folder: folder) }

    context 'when delete file_item successfully' do
      it do
        expect do
          delete "/folders/#{folder.id}/file_items/#{file_item.id}"
        end.to change(FileItemRecord, :count).by(0)

        expect(response).to have_http_status(:no_content)
      end
    end

    context 'when file_item not exists' do
      it do
        delete "/folders/#{folder.id}/file_items/0"

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
