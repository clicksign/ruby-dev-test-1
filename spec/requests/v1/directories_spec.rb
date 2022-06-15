require 'rails_helper'

RSpec.describe "Directories API", type: :request do

  context "GET /v1/directories" do
    let!(:directories) { create_list(:directory, 5)}

    it "returns directories" do
      get v1_directories_path
      expected_directories = directories.map do |dir|
        build_directory_json(dir)
      end
      expect(body_json).to contain_exactly *expected_directories
    end

    it "returns success status" do
      get v1_directories_path
      expect(response).to have_http_status(:ok)
    end
  end

  context "POST /v1/directories" do
    let(:directory_params) do
      { directory: attributes_for(:directory) }
    end

    it "add a new directory" do
      expect do
        post v1_directories_path, params: directory_params
      end.to change(Directory, :count).by(1)
    end

    it "returns success status" do
      post v1_directories_path, params: directory_params
      expect(response).to have_http_status(:ok)
    end
  end
end

def build_directory_json(directory)
  json = directory.as_json
  json['path'] = directory.path.as_json
  json['get_archives'] = directory.get_archives.as_json
  json
end

def body_json(symbolize_keys: false)
  json = JSON.parse(response.body)
  symbolize_keys ? json.deep_symbolize_keys : json
end