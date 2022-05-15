require "rails_helper"

RSpec.describe "Directories", type: :request do
  describe "INDEX" do
    let(:directory) { create(:directory) }

    context "method GET" do
      let(:url) { api_v1_directories_path }
      let!(:directories) { create_list(:directory_with_subs, 5) }

      it "should return status ok" do
        get url, headers: auth_header
        expect(response).to have_http_status(:ok)
      end

      it "should returns all Directories" do
        get url, headers: auth_header
        expect(body_json.size).to eq(15)
        expect(response.body).to include(directories.first.title)
      end
    end
  end

  describe "CREATE" do
    let(:directory) { create(:directory) }

    context "method POST" do
      let(:url) { api_v1_directories_path }

      context "with valid params" do
        let (:attributes) { attributes_for(:directory) }
        let(:directory_params) { { directory: attributes }.to_json }

        it "create a new Directory" do
          post url, headers: auth_header, params: directory_params
          expect(response).to have_http_status(200)
          expect(response.body).to include(attributes[:title])
        end

        it "should return last Directory" do
          post url, headers: auth_header, params: directory_params
          expected_directory = Directory.last
          expect(body_json["id"]).to eq expected_directory.id
        end

      end

      context "with invalid params" do
        let(:directory_invalid_params) do
          { directory: attributes_for(:directory, title: nil) }.to_json
        end

        it "does not add a new Directory" do
          expect do
            post url, headers: auth_header, params: directory_invalid_params
          end.not_to change(Directory, :count)
        end

        it "should returns error message" do
          post url, headers: auth_header, params: directory_invalid_params
          expect(body_json["title"]).to eq(["can't be blank"])
        end

        it "should return unprocessable_entity status" do
          post url, headers: auth_header, params: directory_invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "UPDATE" do
      let(:directory) { create(:directory) }
      let(:directories) { create_list(:directory, parent: directory) }
      let(:url) { api_v1_directory_path(directory) }

      context "with valid params" do
        let(:new_title) { "New Directory" }
        let(:directory_params) { { directory: { title: new_title } }.to_json }

        it "should updates Directory" do
          patch url, headers: auth_header, params: directory_params
          directory.reload
          expect(directory.title).to eq new_title
        end

        it "should return updated Directory" do
          patch url, headers: auth_header, params: directory_params
          directory.reload
          new_title = directory.title
          expect(body_json["title"]).to eq new_title
        end

        it "should return success status" do
          patch url, headers: auth_header, params: directory_params
          expect(response).to have_http_status(:ok)
        end
      end

      context "with invalid params" do
        let(:directory_invalid_params) do
          { directory: attributes_for(:directory, title: nil) }.to_json
        end

        it "not update Directory" do
          old_title = directory.title
          patch url, headers: auth_header, params: directory_invalid_params
          directory.reload
          expect(directory.title).to eq old_title
        end

        it "should return error message" do
          patch url, headers: auth_header, params: directory_invalid_params
          expect(body_json["title"]).to eq(["can't be blank"])
        end

        it "should returns unprocessable_entity status" do
          patch url, headers: auth_header, params: directory_invalid_params
          expect(response).to have_http_status(:unprocessable_entity)
        end
      end
    end

    context "SHOW" do
      let!(:directory) { create(:directory) }
      let(:url) { api_v1_directory_path(directory) }

      it "should return success status" do
        get url, headers: auth_header
        expect(response).to have_http_status(:ok)
      end

      it "should return directory" do
        get url, headers: auth_header
        expect(body_json["id"]).to eq(directory.id)
      end
    end

    context "DELETE" do
      let!(:directory) { create(:directory) }
      let(:url) { api_v1_directory_path(directory) }

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