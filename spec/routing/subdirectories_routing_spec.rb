require "rails_helper"

RSpec.describe Api::V1::SubdirectoriesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/directories/1/subdirectories").to route_to("api/v1/subdirectories#index", directory_id: '1')
    end

    it "routes to #show" do
      expect(get: "/api/v1/directories/1/subdirectories/1").to route_to("api/v1/subdirectories#show", directory_id: '1', id: '1')
    end


    it "routes to #create" do
      expect(post: "/api/v1/directories/1/subdirectories").to route_to("api/v1/subdirectories#create", directory_id: '1')
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/directories/1/subdirectories/1").to route_to("api/v1/subdirectories#update", directory_id: '1', id: '1')
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/directories/1/subdirectories/1").to route_to("api/v1/subdirectories#update", directory_id: '1', id: '1')
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/directories/1/subdirectories/1").to route_to("api/v1/subdirectories#destroy", directory_id: '1', id: '1')
    end
  end
end
