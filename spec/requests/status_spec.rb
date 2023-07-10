require 'rails_helper'

RSpec.describe Api::V1::StatusController, type: :request do
  describe 'GET /index' do
    let(:response_expected) { { message: 'OK' }.to_json }

    before do
      get api_v1_root_url, as: :json
    end

    it { expect(response).to have_http_status(:ok) }
    it { expect(response.content_type).to match(a_string_including('application/json')) }
    it { expect(response.body).to eq(response_expected) }
  end
end
