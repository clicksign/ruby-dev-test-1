require "rails_helper"

RSpec.describe "PingController", type: :request do
  let(:data) { JSON.parse(response.body, symbolize_names: true) }

  describe "#show GET /ping" do
    let(:url) { "/ping" }

    it "should be return current datetime" do
      get url

      expect(response).to have_http_status :ok
      expect(data[:pong].to_time.strftime("%F %H:%M")).to eq DateTime.current.utc.strftime("%F %H:%M")
    end
  end
end
