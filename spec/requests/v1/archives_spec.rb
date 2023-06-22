# frozen_string_literal: true

require 'swagger_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Archives', type: :request do
  let(:current_user) { create(:user, password: '369') }
  let(:Authorization) { ActionController::HttpAuthentication::Basic.encode_credentials(current_user.name, 369) }

  path '/v1/archives' do
    get 'list' do
      tags 'Archives'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'

      response '200', 'list archives' do
        let!(:archive1) { create(:archive, :with_file, user: current_user) }
        let!(:archive2) { create(:archive, :with_file, :with_folder, user: current_user) }

        run_test! do
          expect(json_response).to contain_exactly(
            hash_including(
              id: archive1.id,
              folder_id: nil,
              name: archive1.name,
              path: archive1.path,
              url: match(TEST_FILE_NAME_REGEX)
            ),
            hash_including(
              id: archive2.id,
              folder_id: archive2.folder.id,
              name: archive2.name,
              path: archive2.path,
              url: match(TEST_FILE_NAME_REGEX)
            )
          )
        end
      end
    end

    post 'create' do
      tags 'Archives'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :archive, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          folder_id: { type: :string, format: 'uuid' },
          file: { type: :string, format: 'byte', example: 'dXNlZCBpbiByYWlscyB0ZXN0Cg==' }
        },
        required: %w[name file]
      }

      response '201', 'create new archive' do
        let(:parent) { create(:archive, :with_file, user: current_user) }
        let(:archive) do
          {
            archive: {
              name: Faker::File.file_name.split('/').second,
              folder_id: parent.id,
              file: 'dXNlZCBpbiByYWlscyB0ZXN0Cg=='
            }
          }
        end

        run_test! do
          expect(json_response).to match({
                                           id: match(UUID_REGEX),
                                           folder_id: parent.id,
                                           name: archive.dig(:archive, :name),
                                           path: match(archive.dig(:archive, :name)),
                                           url: match(%r{^(http://).*(#{archive.dig(:archive, :name)})})
                                         })
        end
      end

      response '422', 'invalid request' do
        let(:archive) { { archive: { name: 'n' } } }

        run_test! do
          expect(response.status).to eq(422)
        end
      end
    end
  end

  path '/v1/archives/{id}' do
    get 'show' do
      tags 'Archives'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :uuid

      response '200', 'show archive' do
        let(:archive) { create(:archive, :with_file, :with_folder, user: current_user) }
        let(:id) { archive.id }

        run_test! do
          expect(json_response).to match({
                                           id: id,
                                           folder_id: match(UUID_REGEX),
                                           name: archive.name,
                                           path: archive.path,
                                           url: match(TEST_FILE_NAME_REGEX)
                                         })
        end
      end
    end

    patch 'update' do
      tags 'Archives'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :uuid
      parameter name: :archive, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          folder_id: { type: :string, format: 'uuid' }
        },
        required: %w[name]
      }

      response '200', 'update archive' do
        let(:archive) { { archive: { name: Faker::File.file_name.split('/').second } } }
        let(:id) { create(:archive, :with_file, :with_folder, user: current_user).id }

        run_test! do
          expect(json_response).to match({
                                           id: id,
                                           folder_id: match(UUID_REGEX),
                                           name: archive.dig(:archive, :name),
                                           path: match(archive.dig(:archive, :name)),
                                           url: match(TEST_FILE_NAME_REGEX)
                                         })
        end
      end
    end
  end

  path '/v1/archives/{id}' do
    delete 'destroy' do
      tags 'Archives'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :uuid

      response '204', 'destroy archive' do
        let(:id) { create(:archive, :with_file, user: current_user).id }

        run_test! do
          expect(Folder.exists?(id)).to be_falsey
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
