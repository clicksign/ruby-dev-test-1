# frozen_string_literal: true

require 'swagger_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Folders', type: :request do
  let(:current_user) { create(:user, password: '369') }
  let(:Authorization) { ActionController::HttpAuthentication::Basic.encode_credentials(current_user.name, 369) }

  path '/v1/folders' do
    get 'list' do
      tags 'Folders'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'

      response '200', 'list folders' do
        let!(:folder1) { create(:folder, :with_archives, user: current_user) }
        let!(:folder2) { create(:folder, parent: folder1, user: current_user) }

        run_test! do
          expect(json_response).to contain_exactly(
            hash_including(
              id: folder1.id,
              parent_folder_id: nil,
              name: folder1.name,
              path: folder1.path,
              archives: match_array(
                folder1.archives.map do |ar|
                  ArchiveSerializer.new(ar).serializable_hash.merge({ url: match(TEST_FILE_NAME_REGEX) })
                end
              )
            ),
            hash_including(
              id: folder2.id,
              parent_folder_id: folder1.id,
              name: folder2.name,
              path: folder2.path,
              archives: []
            )
          )
        end
      end
    end

    post 'create' do
      tags 'Folders'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :folder, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          parent_folder_id: { type: :string, format: 'uuid' }
        },
        required: %w[name]
      }

      response '201', 'create new folder' do
        let(:parent) { create(:folder) }
        let(:folder) do
          {
            folder: {
              name: Faker::File.dir(segment_count: 1),
              parent_folder_id: parent.id
            }
          }
        end

        run_test! do
          expect(json_response).to match({
                                           id: match(UUID_REGEX),
                                           parent_folder_id: parent.id,
                                           name: folder.dig(:folder, :name),
                                           path: match(folder.dig(:folder, :name)),
                                           archives: []
                                         })
        end
      end

      response '422', 'invalid request' do
        let(:folder) { { folder: { name: 'n' } } }

        run_test! do
          expect(response.status).to eq(422)
        end
      end
    end
  end

  path '/v1/folders/{id}' do
    get 'show' do
      tags 'Folders'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :uuid

      response '200', 'show folder' do
        let(:folder) { create(:folder, :with_parent, :with_archives, user: current_user) }
        let(:id) { folder.id }

        run_test! do
          expect(json_response).to match({
                                           id: id,
                                           parent_folder_id: match(UUID_REGEX),
                                           name: folder.name,
                                           path: folder.path,
                                           archives: match_array(
                                             folder.archives.map do |ar|
                                               ArchiveSerializer.new(ar)
                                                .serializable_hash
                                                .merge({
                                                         url: match(TEST_FILE_NAME_REGEX)
                                                       })
                                             end
                                           )
                                         })
        end
      end
    end

    patch 'update' do
      tags 'Folders'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :uuid
      parameter name: :folder, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          parent_folder_id: { type: :string, format: 'uuid' }
        },
        required: %w[name]
      }

      response '200', 'update folder' do
        let(:folder) { { folder: { name: Faker::File.dir(segment_count: 1) } } }
        let(:id) { create(:folder, :with_parent, user: current_user).id }

        run_test! do
          expect(json_response).to match({
                                           id: id,
                                           parent_folder_id: match(UUID_REGEX),
                                           name: folder.dig(:folder, :name),
                                           path: match(folder.dig(:folder, :name)),
                                           archives: []
                                         })
        end
      end
    end
  end

  path '/v1/folders/{id}' do
    delete 'destroy' do
      tags 'Folders'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :uuid

      response '204', 'destroy folder' do
        let(:id) { create(:folder, user: current_user).id }

        run_test! do
          expect(Folder.exists?(id)).to be_falsey
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
