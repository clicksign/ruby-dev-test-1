require 'rails_helper'

RSpec.describe "/documents", type: :request do
  let(:document) { create(:document) }

  let(:valid_attributes) {
    { title: Faker::File.file_name, description: Faker::Lorem.sentence, file: file }
  }

  let(:invalid_attributes) {
    { title: nil, description: nil, file: nil }
  }

  let(:file) { Rack::Test::UploadedFile.new("#{Rails.root}/spec/factories/files/file_mock.txt") }

  describe 'request' do
    describe 'GET /index' do
      it 'renders a successful response' do
        get documents_url
        expect(response).to be_successful
      end
    end

    describe 'GET /show' do
      it 'renders a successful response' do
        get document_url(document)
        expect(response).to be_successful
      end
    end

    describe 'GET /new' do
      it 'renders a successful response' do
        get new_document_url
        expect(response).to be_successful
      end
    end

    describe 'GET /edit' do
      it 'renders a successful response' do
        get edit_document_url(document)
        expect(response).to be_successful
      end
    end

    describe 'POST /create' do
      context 'with valid parameters' do
        it 'creates a new Document' do
          expect { post documents_url, params: { document: valid_attributes } }
            .to change(Document, :count).by(1)
        end

        it 'redirects to the created document' do
          post documents_url, params: { document: valid_attributes }
          expect(response).to redirect_to(document_url(Document.last))
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Document' do
          expect { post documents_url, params: { document: invalid_attributes } }
            .to change(Document, :count).by(0)
        end

        it 'returns unprocessable entity status code' do
          post documents_url, params: { document: invalid_attributes }

          expect(response.status).to eq(422)
        end
      end
    end

    describe 'DELETE /destroy' do
      before do
        create(:document)
      end

      it 'destroys the requested document' do
        expect { delete document_url(Document.last.id) }.to change(Document, :count).by(-1)
      end

      it 'redirects to the documents list' do
        delete document_url(Document.last.id)
        expect(response).to redirect_to(documents_url)
      end
    end
  end
end
