require "rails_helper"

RSpec.describe Api::V1::AttachFilesController, type: :routing do
  describe "routing" do
    it "routes to #show" do
      expect(get: "api/v1/attach_files/1").to route_to("api/v1/attach_files#show", id: "1")
    end

    it "routes to #create" do
      expect(post: "api/v1/attach_files").to route_to("api/v1/attach_files#create")
    end

    it "routes to #update via PUT" do
      expect(put: "api/v1/attach_files/1").to route_to("api/v1/attach_files#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "api/v1/attach_files/1").to route_to("api/v1/attach_files#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "api/v1/attach_files/1").to route_to("api/v1/attach_files#destroy", id: "1")
    end
  end
end
