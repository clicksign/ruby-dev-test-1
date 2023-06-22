# frozen_string_literal: true

require 'swagger_helper'

# rubocop:disable Metrics/BlockLength
RSpec.describe 'Users', type: :request do
  let(:current_user) { create(:user, password: '369') }
  let(:Authorization) { ActionController::HttpAuthentication::Basic.encode_credentials(current_user.name, 369) }

  path '/v1/users' do
    get 'list' do
      tags 'Users'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'

      response '200', 'list users' do
        run_test! do
          expect(json_response).to contain_exactly(hash_including(id: current_user.id, name: current_user.name))
        end
      end
    end

    post 'create' do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[name password password_confirmation]
      }

      response '201', 'create new user' do
        let(:pwd) { Faker::Internet.password }
        let(:user) { { user: { name: Faker::Internet.username, password: pwd, password_confirmation: pwd } } }

        run_test! do
          expect(json_response).to match({ id: match(UUID_REGEX), name: user.dig(:user, :name) })
        end
      end

      response '422', 'invalid request' do
        let(:user) { { name: Faker::Internet.username } }

        run_test! do
          expect(response.status).to eq(422)
        end
      end
    end
  end

  path '/v1/users/{id}' do
    get 'show' do
      tags 'Users'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :uuid

      response '200', 'show user' do
        let(:user) { create(:user) }
        let(:id) { user.id }

        run_test! do
          expect(json_response).to match({ id: id, name: user.name })
        end
      end
    end

    patch 'update' do
      tags 'Users'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :uuid
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[name password password_confirmation]
      }

      response '200', 'update user' do
        let(:user) { { user: { name: Faker::Internet.username } } }
        let(:id) { create(:user).id }

        run_test! do
          expect(json_response).to match({ id: id, name: user.dig(:user, :name) })
        end
      end
    end
  end

  path '/v1/users/{id}' do
    delete 'destroy' do
      tags 'Users'
      security [basicAuth: {}]
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :uuid

      response '204', 'destroy user' do
        let(:id) { create(:user).id }

        run_test! do
          expect(User.exists?(id)).to be_falsey
        end
      end
    end
  end
end
# rubocop:enable Metrics/BlockLength
