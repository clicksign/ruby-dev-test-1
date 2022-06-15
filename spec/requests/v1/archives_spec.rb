require 'rails_helper'

RSpec.describe "Archives API", type: :request do
  context "POST /v1/archives" do
    let(:archive_params) do
      { archive: attributes_for(:archive, :with_data ).merge(directory: "my directory") }
    end

    it "adds a new archive" do
      expect do
        post v1_archives_path, params: archive_params
      end.to change(Archive, :count).by(1)
    end

    it "returns success status" do 
      post v1_archives_path, params: archive_params
      expect(response).to have_http_status(:ok)
    end

  end
end