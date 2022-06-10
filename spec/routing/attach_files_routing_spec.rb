require "rails_helper"

RSpec.describe AttachFilesController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/attach_files").to route_to("attach_files#index")
    end

    it "routes to #show" do
      expect(get: "/attach_files/1").to route_to("attach_files#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/attach_files").to route_to("attach_files#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/attach_files/1").to route_to("attach_files#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/attach_files/1").to route_to("attach_files#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/attach_files/1").to route_to("attach_files#destroy", id: "1")
    end
  end
end
