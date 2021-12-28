# frozen_string_literal: true

require 'swagger_helper'

required_attributes = %w[name type]
tag_doc = 'Repository'
path_doc = '/repositories'
path_doc_id = "#{path_doc}/{id}"
properties = {
  name: { type: :string },
  type: { type: :string, enum: %w[Folder Archive] },
  origin_id: { type: :string, format: 'uuid' }
}

RSpec.describe 'Repositories', type: :request do
  path path_doc do
    get 'list of repositories' do
      tags tag_doc
      produces 'application/json'
      parameter name: :tipo, in: :query, type: :string, schema: { type: :string, enum: %w[Folder Archive] },
                required: false

      response '200', 'repositories found' do
        let!(:repository) { create(:repository, :folder) }
        let(:tipo) { 'Folder' }

        before do |example|
          submit_request(example.metadata)
        end

        it 'Return HTTP 200' do
          expect(response.status).to eq(200)
        end
      end
    end
  end

  path path_doc_id do
    get 'search for a repository' do
      tags tag_doc
      produces 'application/json'
      parameter name: :id, in: :path, type: :string, format: 'uuid'

      response '200', 'repository found' do
        let!(:repository) { create(:repository, :folder) }
        let(:id) { repository.id }

        before do |example|
          submit_request(example.metadata)
        end

        it 'return HTTP 200' do
          expect(response.status).to eq(200)
        end
      end

      response '404', 'repository not found' do
        let(:id) { 1 }

        before do |example|
          submit_request(example.metadata)
        end

        it 'Return HTTP 404' do
          expect(response.status).to eq(404)
        end
      end
    end
  end

  path path_doc_id do
    patch 'updating a repository' do
      tags tag_doc
      produces 'application/json'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string, format: 'uuid'
      parameter name: :repository, in: :body, schema: {
        type: :object,
        properties: properties,
        required: required_attributes
      }

      response '200', 'updated repository' do
        let(:repository) { create(:repository, :folder) }
        let(:id) { repository.id }

        before do |example|
          submit_request(example.metadata)
        end

        it 'return HTTP 200' do
          expect(response.status).to eq(200)
        end
      end

      response '400', 'repository not updated' do
        let(:repository) do
          {
            name: '',
            type: 'Folder'
          }
        end
        let(:id) { create(:repository, :folder).id }

        before do |example|
          submit_request(example.metadata)
        end

        it 'return HTTP 400' do
          expect(response.status).to eq(400)
        end
      end

      response '404', 'repository not found' do
        let(:repository) do
          {
          }
        end
        let(:id) { 1 }

        before do |example|
          submit_request(example.metadata)
        end

        it 'return HTTP 404' do
          expect(response.status).to eq(404)
        end
      end
    end
  end

  path path_doc do
    post 'creating a repository' do
      tags tag_doc
      produces 'application/json'
      consumes 'application/json'
      parameter name: :repository, in: :body, schema: {
        type: :object,
        properties: {
          repository: {
            type: :array,
            items: {
              type: :object,
              properties: properties,
              required: required_attributes
            }
          }
        }
      }

      response '200', 'created repository' do
        let(:repository) do
          {
            name: 'Fernando',
            type: 'Folder'
          }
        end

        before do |example|
          submit_request(example.metadata)
        end

        it 'return HTTP 200' do
          expect(response.status).to eq(200)
        end
      end

      response '400', 'uncreated repository' do
        let(:repository) do
          {
            name: '',
            type: 'Folder'
          }
        end

        before do |example|
          submit_request(example.metadata)
        end

        it 'return HTTP 400' do
          expect(response.status).to eq(400)
        end
      end
    end
  end

  path path_doc_id do
    delete 'deleting a repository' do
      tags tag_doc
      parameter name: :id, in: :path, type: :string, format: 'uuid'

      response '200', 'deleted repository' do
        let!(:repository) { create(:repository, :folder) }
        let(:id) { repository.id }

        before do |example|
          submit_request(example.metadata)
        end

        it 'return HTTP 200' do
          expect(response.status).to eq(200)
        end
      end

      response '400', 'undeleted repository' do
        let(:repository) { instance_double(Repository, id: 1) }
        let(:id) { repository.id }

        before do |example|
          allow(Repository).to receive(:find).with(id.to_s).and_return(repository)
          allow(repository).to receive(:destroy).and_return(false)
          submit_request(example.metadata)
        end

        it 'return HTTP 400' do
          expect(response.status).to eq(400)
        end
      end

      response '404', 'repository not found' do
        let(:id) { 1 }

        before do |example|
          submit_request(example.metadata)
        end

        it 'return HTTP 404' do
          expect(response.status).to eq(404)
        end
      end
    end
  end
end
