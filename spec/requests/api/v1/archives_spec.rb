require 'rails_helper'

RSpec.describe Api::V1::ArchivesController, type: :request do
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

  describe "#index - GET /api/v1/archives" do
    let(:url) { "/api/v1/archives" }

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

    context "when have archives" do
      let!(:archive) { create :archive }
      let(:serialized) { ArchiveSerializer.new.serialize(archive)&.deep_symbolize_keys }

      it "returns its data" do
        get url

        expect(response).to have_http_status :ok
        expect(data.size).to eq 1
        expect(data).to eq [serialized]
      end
    end

    context "searching" do
      let!(:archive) { create :archive, name: "dir1" }

      describe "by fuzzy" do
        it "returns filtered" do

          get url, params: { q: "dir1" }

          expect(response).to have_http_status :ok
          expect(data.size).to eq 1
        end
      end

      describe "by directory_id" do
        let(:directory) { create :directory }
        let!(:archive) { create :archive, directory: directory }

        it "returns filtered" do
          get url, params: { directory_id: [directory.id] }

          expect(response).to have_http_status :ok
          expect(data.size).to eq 1
        end
      end
    end

    context "when does not have archives" do
      it "returns empty data" do
        get url

        expect(response).to have_http_status :ok
        expect(data).to eq []
      end
    end

    context "when paginating archives" do
      before do
        Archive.destroy_all
      end

      let!(:archives) { create_list(:archive, 10, user: user) }

      it "returns first N results per page with its pagination headers" do
        get url, params: { page: 1, size: 5 }

        expect(data.size).to eq 5
        expect(response).to include_pagination_headers(page: 1, per_page: 5, total_page: 2, total: 10)
      end
    end

    context "when sort by created_at" do
      let!(:archives) { create_list(:archive, 10, user: user) }
      let(:serialized) do
        JSON.parse(Panko::ArraySerializer.new(archives, { each_serializer: ArchiveSerializer }).to_json, symbolize_names: true)
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

  describe "#show GET /api/v1/archives/:id" do
    let(:archive) { create :archive }
    let(:url) { "/api/v1/archives/#{archive.id}" }

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

    context "when archive exists" do
      let(:serialized) { ArchiveSerializer.new.serialize(archive)&.deep_symbolize_keys }

      it "returns its data" do
        get url

        expect(data).to eq serialized
        expect(response).to have_http_status :ok
      end
    end

    context "when archive is not found" do
      let(:url) { "/api/v1/archives/0" }

      it "returns not found" do
        get url

        expect(data[:error]).to eq "not_found"
        expect(response).to have_http_status :not_found
      end
    end
  end # #show

  describe "#create POST /api/v1/archives" do
    let(:directory) { create :directory }
    let(:url) { "/api/v1/archives" }
    let!(:blob) { fixture_file_upload "doc-test.docx" }

    let(:params) do
      {
        directory_id: directory.id,
        file: blob
      }
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

    context "when creates archive" do
      it "should create a new archive" do
        expect do
          post url, params: params
        end.to change { Archive.count }.by(1)
      end

      it "returns its data" do
        post url, params: params

        expect(response).to have_http_status :created
        expect(data[:name]).to eq blob.original_filename
        expect(data[:directory_id]).to eq directory.id
      end
    end

    context "when not create archive" do
      it "returns its errors" do
        post url, params: unpermitted_params

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end # #create

  describe "#update PATCH/PUT /api/v1/archives/:id" do
    let(:directory) { create :directory }
    let(:archive) { create :archive }
    let(:url) { "/api/v1/archives/#{archive.id}" }
    let!(:blob) { fixture_file_upload "doc-test.docx" }
    let(:update_params) do
      {
        directory_id: directory.id,
        file: blob
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

    context "when updates archive" do
      it "returns its data and updates archive" do
        patch url, params: update_params

        archive.reload

        expect(response).to have_http_status :ok
        expect(archive.name).to eq blob.original_filename
        expect(archive.directory_id).to eq update_params[:directory_id]
      end
    end

    context "when not updates archive" do
      it "returns its errors" do
        patch url, params: unpermitted_params

        expect(response).to have_http_status :unprocessable_entity
      end
    end

    context "when doesn't find archive" do
      let(:url) { "/api/v1/archives/0" }

      it "returns not found" do
        patch url, params: update_params

        expect(data[:error]).to eq "not_found"
        expect(response).to have_http_status :not_found
      end
    end
  end # #update

  describe "#destroy DELETE /api/v1/archives/:id" do
    let(:archive) { create :archive, user: user }
    let(:url) { "/api/v1/archives/#{archive.id}" }

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

    context "when destroys archive" do
      pending "should destroyed"
      # it "should destroyed" do
      #   expect do
      #     delete url
      #   end.to change(Archive, :count).from(1).to(0)
      # end

      it "returns no content" do
        delete url

        expect(response).to have_http_status :no_content
      end
    end

    context "when doesn't find archive" do
      let(:url) { "/api/v1/archives/0" }

      it "returns not found" do
        delete url

        expect(data[:error]).to eq "not_found"
        expect(response).to have_http_status :not_found
      end
    end
  end # #destroy
end
