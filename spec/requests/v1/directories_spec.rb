require 'rails_helper'

RSpec.describe "Directories API", type: :request do

  context "GET /v1/directories" do

    let!(:directories) { create_list(:directory, 5)}
    
    it "returns directories" do
      get v1_directories_path
      binding.pry
      expected_directories = directories.as_json()
      result = body_json.as_json(only: ["id", "name"])
      expect(body_json).to contain_exactly *expected_directories
    end

    it "returns success status" do
      get url, headers: auth_header(user)
      expect(response).to have_http_status(:ok)
    end
  end
  context "POST /v1/directories" do
    
  end
end

def body_json(symbolize_keys: false)
  json = JSON.parse(response.body)
  symbolize_keys ? json.deep_symbolize_keys : json
end