require 'rails_helper'

RSpec.describe "Api::V1::Archives", type: :request do
  describe "GET /index" do
    context 'when there are many archives they will be paginated' do
      before do
        create_list(:archive, 30, :with_document)
        get api_v1_archives_path, params: { page: 2 }
      end

      it 'return success' do
        archive = Archive.find(parsed_response.dig('entries', 0, 'id'))
        expect(response).to have_http_status(:success)
        expect(parsed_response.dig('entries', 0, 'document_url')).to match(URI.regexp)
        expect(parsed_response.dig('entries', 0, 'name')).to eq(archive.name)
        expect(parsed_response.dig('entries', 0, 'size')).to eq(archive.size)
        expect(parsed_response.dig('entries').count).to eq(5)
        expect(parsed_response.dig('pagination', 'found')).to eq(30)
        expect(parsed_response.dig('pagination', 'current_page')).to eq(2)
      end
    end
  end

  describe 'GET /show' do
    context 'when archive' do
      let(:archive) { create(:archive, :with_document) }

      before { get api_v1_archive_path(archive.id) }

      it 'return success' do
        expect(response).to have_http_status(:success)
        expect(parsed_response.dig('document_url')).to match(URI.regexp)
        expect(parsed_response.dig('name')).to eq(archive.name)
        expect(parsed_response.dig('size')).to eq(archive.size)
      end
    end
  end

  describe 'GET /create' do
    context 'when trying to create archive' do
      let(:directory) { create(:directory) }
      let(:directory_id) { directory.id }
      let(:document) { Rack::Test::UploadedFile.new(Rails.root.join('spec/files/first_file.txt')) }

      let(:params) do
        {
          directory_id: directory_id,
          document: document
        }
      end

      before { post api_v1_archives_path, params: params }

      context ' with invalid data' do
        context 'directory id' do
          let(:directory_id) { nil }

          it 'return error' do
            expect(response).to have_http_status(:bad_request)
            expect(parsed_response.dig('messages')).to eq(["A validação falhou: Directory é obrigatório(a)"])
          end
        end

        context 'document' do
          let(:document) { nil }

          it 'return error' do
            expect(response).to have_http_status(:bad_request)
            expect(parsed_response.dig('messages')).to eq(["Document é obrigatório"])
          end
        end

        context 'content size invalid' do
          let(:document) { Rack::Test::UploadedFile.new(Rails.root.join('spec/files/lorem_ipsum.txt')) }

          it 'return error' do
            expect(response).to have_http_status(:bad_request)
            expect(parsed_response.dig('messages')).to eq(["Tamanho do arquivo deve ser de até 5MB."])
          end
        end

        context 'params nil' do
          let(:params) { nil }

          it 'return error' do
            expect(response).to have_http_status(:bad_request)
            expect(parsed_response.dig('messages')).to eq(["Document é obrigatório, Directory é obrigatório"])
          end
        end
      end

      context 'with valid data' do
        context 'to create a archive' do
          it 'return success' do
            archive = Archive.last
            expect(response).to have_http_status(:success)
            expect(parsed_response.dig('document_url')).to match(URI.regexp)
            expect(parsed_response.dig('name')).to eq(archive.name)
            expect(parsed_response.dig('size')).to eq(archive.size)
          end
        end
      end
    end
  end
end
