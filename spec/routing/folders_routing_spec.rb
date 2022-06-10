require "rails_helper"

RSpec.describe Api::V1::FoldersController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "api/v1/folders").to route_to("api/v1/folders#index")
    end

    it "routes to #show" do
      expect(get: "api/v1/folders/1").to route_to("api/v1/folders#show", id: "1")
    end

    it "routes to #sub_folders" do
      expect(get: "api/v1/folders/1/sub_folders").to route_to({ controller: "api/v1/folders", action: "sub_folders", id: "1" })
    end

    it "routes to #create" do
      expect(post: "api/v1/folders").to route_to("api/v1/folders#create")
    end

    it "routes to #update via PUT" do
      expect(put: "api/v1/folders/1").to route_to("api/v1/folders#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "api/v1/folders/1").to route_to("api/v1/folders#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "api/v1/folders/1").to route_to("api/v1/folders#destroy", id: "1")
    end
  end
end
