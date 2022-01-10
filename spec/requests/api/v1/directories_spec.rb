require "rails_helper"

RSpec.describe "Directories", type: :request do
  describe "GET /index" do
    let(:directory) { create(:directory) }

    context "when GET /directories" do
      let(:url) { "/api/v1/directories" }
      let!(:directories) { create_list(:directory_with_subs, 5) }

      it "returns all Directories" do
        get url, headers: auth_header
        expect(body_json["directories"].size).to eq(15)
      end

      it "returns success status" do
        get url, headers: auth_header
        expect(response).to have_http_status(:ok)
      end
    end

    context "when POST /directories" do
      let(:url) { "/api/v1/directories" }

      context "when with valid params" do
        let(:directory_params) { { directory: attributes_for(:directory) }.to_json }

        it "adds a new Directory" do
          expect do
            post url, headers: auth_header, params: directory_params
          end.to change(Directory, :count).by(1)
        end

        it "returns last added Directory" do
          post url, headers: auth_header, params: directory_params
          expected_directory = Directory.last
          expect(body_json["directory"]["id"]).to eq expected_directory.id
        end

        it "returns success status" do
          post url, headers: auth_header, params: directory_params
          expect(response).to have_http_status(:ok)
        end
      end

      context "when with invalid params" do
        let(:directory_invalid_params) do
          { directory: attributes_for(:directory, name: nil) }.to_json
        end

        it "does not add a new Directory" do
          expect do
            post url, headers: auth_header, params: directory_invalid_params
          end.not_to change(Directory, :count)
        end

        it "returns error message" do
          post url, headers: auth_header, params: directory_invalid_params
          expect(body_json["errors"]["fields"]).to have_key("name")
        end

        it "returns unprocessable_entity status" do
          post url, headers: auth_header, params: directory_invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when PATCH /directories/:id" do
      let(:directory) { create(:directory) }
      let(:directories) { create_list(:directory, parent: directory) }
      let(:url) { "/api/v1/directories/#{directory.id}" }

      context "when with valid params" do
        let(:new_name) { "My new Directory" }
        let(:directory_params) { { directory: { name: new_name } }.to_json }

        it "updates Directory" do
          patch url, headers: auth_header, params: directory_params
          directory.reload
          expect(directory.name).to eq new_name
        end

        it "returns updated Directory" do
          patch url, headers: auth_header, params: directory_params
          directory.reload
          new_name = directory.name
          expect(body_json["directory"]["name"]).to eq new_name
        end

        it "returns success status" do
          patch url, headers: auth_header, params: directory_params
          expect(response).to have_http_status(:ok)
        end
      end

      context "with invalid params" do
        let(:directory_invalid_params) do
          { directory: attributes_for(:directory, name: nil) }.to_json
        end

        it "does not update Directory" do
          old_name = directory.name
          patch url, headers: auth_header, params: directory_invalid_params
          directory.reload
          expect(directory.name).to eq old_name
        end

        it "returns error message" do
          patch url, headers: auth_header, params: directory_invalid_params
          expect(body_json["errors"]["fields"]).to have_key("name")
        end

        it "returns unprocessable_entity status" do
          patch url, headers: auth_header, params: directory_invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "when DELETE /directories/:id" do
      let!(:directory) { create(:directory) }
      let(:url) { "/api/v1/directories/#{directory.id}" }

      it "removes Directory" do
        expect do
          delete url, headers: auth_header
        end.to change(Directory, :count).by(-1)
      end

      it "returns success status" do
        delete url, headers: auth_header
        expect(response).to have_http_status(:no_content)
      end

      it "does not return any body content" do
        delete url, headers: auth_header
        expect(body_json).not_to be_present
      end
    end
  end
end
