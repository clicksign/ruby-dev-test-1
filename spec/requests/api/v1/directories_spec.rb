require 'rails_helper'

RSpec.describe Api::V1::DirectoriesController, type: :request do
  let(:data) { JSON.parse(response.body, symbolize_names: true) }
  let(:user) { create :user }
  let(:params) do
    { name: "Dirr" }
  end

  let(:unpermitted_params) do
    {
      name: nil
    }
  end

  describe "#index - GET /api/v1/directories" do
    let(:url) { "/api/v1/directories" }

    context "requirements" do
      it "requires basic authenticate" do
        reset_authentication!
        get url

        expect(response).to have_http_status :unauthorized
      end
    end

    before do
      basic_authentication!(user: user)
    end

    context "when have directories" do
      let!(:directory) { create :directory }
      let(:serialized) { DirectorySerializer.new.serialize(directory)&.deep_symbolize_keys }

      it "returns its data" do
        get url

        expect(response).to have_http_status :ok
        expect(data.size).to eq 1
        expect(data).to eq [serialized]
      end
    end

    context "searching" do
      let!(:directory) { create :directory, name: "dir1" }

      describe "by fuzzy" do
        it "returns filtered" do

          get url, params: { q: "dir1" }

          expect(response).to have_http_status :ok
          expect(data.size).to eq 1
        end
      end

      describe "by parent_id" do
        let(:parent) { create :directory }
        let!(:directory) { create :directory, parent: parent }

        it "returns filtered" do
          get url, params: { parent_id: [parent.id] }

          expect(response).to have_http_status :ok
          expect(data.size).to eq 1
        end
      end
    end

    context "when does not have directories" do
      it "returns empty data" do
        get url

        expect(response).to have_http_status :ok
        expect(data).to eq []
      end
    end

    context "when paginating directories" do
      before do
        Directory.destroy_all
      end

      let!(:directories) { create_list(:directory, 10, user: user) }

      it "returns first N results per page with its pagination headers" do
        get url, params: { page: 1, size: 5 }

        expect(data.size).to eq 5
        expect(response).to include_pagination_headers(page: 1, per_page: 5, total_page: 2, total: 10)
      end
    end

    context "when sort by created_at" do
      let!(:directories) { create_list(:directory, 10, user: user) }
      let(:serialized) do
        JSON.parse(Panko::ArraySerializer.new(directories, { each_serializer: DirectorySerializer }).to_json, symbolize_names: true)
      end

      describe "asc" do
        it "returns asc sort by created_at" do
          get url, params: { sort: ["created_at:asc"] }

          expect(data).to match_array serialized.sort_by { |a| a[:created_at] }
        end
      end

      describe "desc" do
        it "returns asc sort by created_at" do
          get url, params: { sort: ["created_at:desc"] }

          expect(data).to match_array serialized.sort_by { |a| a[:created_at] }.reverse
        end
      end
    end
  end # #index

  describe "#show GET /api/v1/directories/:id" do
    let(:directory) { create :directory }
    let(:url) { "/api/v1/directories/#{directory.id}" }

    context "requirements" do
      it "requires basic authenticate" do
        reset_authentication!
        get url

        expect(response).to have_http_status :unauthorized
      end
    end

    before do
      basic_authentication!(user: user)
    end

    context "when directory exists" do
      let(:serialized) { DirectoryShowSerializer.new.serialize(directory)&.deep_symbolize_keys }

      it "returns its data" do
        get url

        expect(data).to eq serialized
        expect(response).to have_http_status :ok
      end
    end

    context "when directory is not found" do
      let(:url) { "/api/v1/directories/0" }

      it "returns not found" do
        get url

        expect(data[:error]).to eq "not_found"
        expect(response).to have_http_status :not_found
      end
    end
  end # #show

  describe "#create POST /api/v1/directories" do
    let(:url) { "/api/v1/directories" }
    let(:params) do
      { name: "Dirr22" }
    end

    context "requirements" do
      it "requires basic authenticate" do
        reset_authentication!
        post url, params: params

        expect(response).to have_http_status :unauthorized
      end
    end

    before do
      basic_authentication!(user: user)
    end

    context "when creates directory" do
      it "should create a new directory" do
        expect do
          post url, params: params
        end.to change { Directory.count }.by(1)
      end

      it "returns its data" do
        post url, params: params

        expect(response).to have_http_status :created
        expect(data[:name]).to eq params[:name]
      end
    end

    context "when not create directory" do
      it "returns its errors" do
        post url, params: unpermitted_params

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end # #create

  describe "#update PATCH/PUT /api/v1/directories/:id" do
    let(:parent) { create :directory }
    let(:directory) { create :directory }
    let(:url) { "/api/v1/directories/#{directory.id}" }
    let(:update_params) do
      {
        name: "DIIRsss",
        parent_id: parent.id
      }
    end

    context "requirements" do
      it "requires basic authenticate" do
        reset_authentication!
        patch url, params: update_params

        expect(response).to have_http_status :unauthorized
      end
    end

    before do
      basic_authentication!(user: user)
    end

    context "when updates directory" do
      it "returns its data and updates directory" do
        patch url, params: update_params

        directory.reload

        expect(response).to have_http_status :ok
        expect(directory.name).to eq update_params[:name]
        expect(directory.parent_id).to eq update_params[:parent_id]
      end
    end

    context "when not updates directory" do
      it "returns its errors" do
        patch url, params: unpermitted_params

        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context "when doesn't find directory" do
      let(:url) { "/api/v1/directories/0" }

      it "returns not found" do
        patch url, params: update_params

        expect(data[:error]).to eq "not_found"
        expect(response).to have_http_status :not_found
      end
    end
  end # #update

  describe "#destroy DELETE /api/v1/directories/:id" do
    let(:directory) { create :directory }
    let(:url) { "/api/v1/directories/#{directory.id}" }

    context "requirements" do
      it "requires basic authenticate" do
        reset_authentication!
        delete url

        expect(response).to have_http_status :unauthorized
      end
    end

    before do
      basic_authentication!(user: user)
    end

    context "when destroys directory" do
      pending "should destroyed"
      # it "should destroyed" do
      #   expect do
      #     delete url
      #   end.to change(Directory, :count).by(-1)
      # end

      it "returns no content" do
        delete url

        expect(response).to have_http_status :no_content
      end
    end

    context "when doesn't find directory" do
      let(:url) { "/api/v1/directories/0" }

      it "returns not found" do
        delete url

        expect(data[:error]).to eq "not_found"
        expect(response).to have_http_status :not_found
      end
    end
  end # #destroy
end
