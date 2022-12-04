require 'rails_helper'

RSpec.describe "FileUploads", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/file_uploads/index"
      expect(response).to have_http_status(:success)
    end
  end

end
