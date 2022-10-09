# frozen_string_literal: true

RSpec.describe('Directories', type: :request) do
  let(:root_directory) { Directory.top_level.first }

  describe 'GET /index' do
    let(:endpoint) { directories_path }
    let(:directories) { create_list(:directory, 2, parent: root_directory) }
    let(:expected) do
      HashWithIndifferentAccess.new(
        {
          id: be_a(Numeric),
          name: be_a(String),
          parent_id: be_a(Numeric).or(be_nil),
          created_at: be_a(String),
          updated_at: be_a(String)
        }
      )
    end

    before(:each) do
      directories
      get(endpoint)
    end

    it { expect(response).to(have_http_status(:ok)) }

    it 'return correct body' do
      body = JSON.parse(response.body)

      expect(body.count).to(eq(3))
      expect(body).to(all(match(expected)))
    end
  end

  describe 'POST /create' do
    let(:endpoint) { directories_path }
    let(:expected) do
      HashWithIndifferentAccess.new(
        {
          id: be_a(Numeric),
          name: payload[:name],
          parent_id: payload[:parent_id],
          created_at: be_a(String),
          updated_at: be_a(String)
        }
      )
    end
    let(:payload) do
      {
        name: 'test',
        parent_id: root_directory.id
      }
    end

    before(:each) do
      post(endpoint, params: payload)
    end

    it { expect(response).to(have_http_status(:created)) }

    it 'return correct body' do
      body = JSON.parse(response.body)

      expect(body).to(match(expected))
    end
  end
end
