# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Api::V1::Directories', type: :request do
  describe 'GET /index' do
    context 'when there are many directories they will be paginated' do
      before do
        create_list(:directory, 30)
        get api_v1_directories_path, params: { page: 2 }
      end

      it 'return success' do
        expect(response).to have_http_status(:success)
        expect(parsed_response.dig('pagination', 'found')).to eq(30)
        expect(parsed_response.dig('pagination', 'per_page')).to eq(25)
        expect(parsed_response.dig('pagination', 'current_page')).to eq(2)
        expect(parsed_response.dig('entries').count).to eq(5)
        expect(parsed_response.dig('entries', 0, 'subdirectories').count).to eq(0)
      end
    end
  end

  describe 'GET /show' do
    context 'when directory has subdirectories' do
      let(:directory) { create(:directory, :with_subdirectories) }

      before { get api_v1_directory_path(directory.id) }

      it 'return success' do
        expect(response).to have_http_status(:success)
        expect(parsed_response.dig('dirname')).to eq(directory.dirname)
        expect(parsed_response.dig('subdirectories').count).to eq(3)
      end
    end
  end

  describe 'GET /create' do
    context 'when trying to create directory' do
      let(:dirname) { Faker::Name.name.parameterize.underscore }
      let(:directory_id) { nil }

      let(:params) do
        {
          dirname: dirname,
          directory_id: directory_id
        }
      end

      before { post api_v1_directories_path, params: params }

      context ' with invalid data' do
        context 'sub directory id' do
          let(:directory_id) { 'invalid uuid' }

          it 'return error' do
            expect(response).to have_http_status(:bad_request)
            expect(parsed_response.dig('messages')).to eq(['ID do sub diretório é inválido'])
          end
        end

        context 'sub directory id does not exist' do
          let(:directory_id) { SecureRandom.uuid }

          it 'return error' do
            expect(response).to have_http_status(:not_found)
            expect(parsed_response.dig('messages').first).to include("Couldn't find Directory with")
          end
        end

        context 'dirname' do
          let(:dirname) { nil }

          it 'return error' do
            expect(response).to have_http_status(:bad_request)
            expect(parsed_response.dig('messages')).to eq(['Dirname é obrigatório'])
          end
        end

        context 'params nil' do
          let(:params) { nil }
          it 'return error' do
            expect(response).to have_http_status(:bad_request)
            expect(parsed_response.dig('messages')).to eq(["Dirname é obrigatório"])
          end
        end
      end

      context 'with valid data' do
        context 'to create a directory without subdirectories' do
          it 'return success' do
            directory = Directory.last
            expect(parsed_response.dig('id')).to eq(directory.id)
            expect(parsed_response.dig('dirname')).to eq(directory.dirname)
            expect(directory.subdirectories.count).to eq(0)
          end
        end

        context 'to create a directory with subdirectories' do
          let(:directory) { create(:directory) }
          let(:directory_id) { directory.id }

          it 'return success' do
            expect(parsed_response.dig('id')).to eq(directory.subdirectories.last.id)
            expect(parsed_response.dig('dirname')).to eq(directory.subdirectories.last.dirname)
            expect(directory.subdirectories.count).to eq(1)
          end
        end
      end
    end
  end
end
