# frozen_string_literal: true

RSpec.describe('Directories', type: :request) do
  let(:root_directory) { Directory.top_level.first }

  describe 'GET /index' do
    let(:endpoint) { directory_arquives_path(directory_id: root_directory.id) }
    let(:arquives) { create_list(:arquive, 2, directory: root_directory, persistence: :local) }
    let(:expected) do
      ActiveSupport::HashWithIndifferentAccess.new(
        {
          id: be_a(Numeric),
          name: be_a(String),
          persistence: 'local',
          path: be_a(String),
          directory_id: root_directory.id,
          created_at: be_a(String),
          updated_at: be_a(String)
        }
      )
    end

    before(:each) do
      arquives
      get(endpoint)
    end

    it { expect(response).to(have_http_status(:ok)) }

    it 'return correct body' do
      body = JSON.parse(response.body)

      expect(body.count).to(eq(2))
      expect(body).to(all(match(expected)))
    end
  end

  describe 'POST /create' do
    let(:endpoint) { arquives_path }
    let(:expected) do
      ActiveSupport::HashWithIndifferentAccess.new(
        {
          id: be_a(Numeric),
          name: be_a(String),
          persistence: persistence.to_s,
          path: be_a(String),
          directory_id: root_directory.id,
          created_at: be_a(String),
          updated_at: be_a(String)
        }
      )
    end
    let(:example_file) { Rails.root.join('spec/support/files/example.txt') }
    let(:file_as_upload) { Rack::Test::UploadedFile.new(example_file) }

    context 'with local persistance' do
      let(:persistence) { 'local' }
      let(:payload) do
        {
          name: 'test',
          persistence:,
          data: file_as_upload,
          directory_id: root_directory.id
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

    context 'with cloud persistance' do
      let(:persistence) { 'cloud' }
      let(:payload) do
        {
          name: 'test',
          persistence:,
          data: file_as_upload,
          directory_id: root_directory.id
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

    context 'with database persistance' do
      let(:expected) do
        ActiveSupport::HashWithIndifferentAccess.new(
          {
            id: be_a(Numeric),
            name: be_a(String),
            persistence:,
            path: nil,
            directory_id: root_directory.id,
            created_at: be_a(String),
            updated_at: be_a(String)
          }
        )
      end
      let(:persistence) { 'database' }
      let(:payload) do
        {
          name: 'test',
          persistence:,
          data: file_as_upload,
          directory_id: root_directory.id
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

  describe 'GET /file' do
    let(:file_contents) { Rails.root.join('spec/support/files/example.txt').read }
    let(:endpoint) { file_arquife_path(id: arquive.id) }

    context 'with local persistance' do
      let(:arquive) { create(:arquive, persistence: :local) }

      before(:each) do
        get(endpoint)
      end

      it { expect(response).to(have_http_status(:ok)) }

      it { expect(response.body).to(eq(file_contents)) }
    end

    context 'with cloud persistance' do
      let(:arquive) { create(:arquive, persistence: :cloud) }

      before(:each) do
        get(endpoint)
      end

      it { expect(response).to(have_http_status(:ok)) }

      it { expect(response.body).to(eq(file_contents)) }
    end

    context 'with database persistance' do
      let(:arquive) { create(:arquive, persistence: :database) }

      before(:each) do
        get(endpoint)
      end

      it { expect(response).to(have_http_status(:ok)) }

      it { expect(response.body).to(eq(file_contents)) }
    end
  end
end
