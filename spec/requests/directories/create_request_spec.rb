RSpec.describe "/api/v1/directories", type: :request do
  describe "creates directory" do
    let(:parent) { Directory.create(name: "root") }
    let(:directory_with_parent_params) { { name: "child", parent_id: parent.id } }
    let(:directory_params) { { name: "root" } }

    it 'creates a root directory' do
      expect {
        post api_v1_directories_url, params: directory_params
      }.to change{ Directory.count }.by(1)
      expect(response).to have_http_status(:ok)
    end

    it 'creates directory without parent' do
      post api_v1_directories_url, params: directory_params
      expect(response.parsed_body.with_indifferent_access[:name]).to eq("root")
      expect(response.parsed_body.with_indifferent_access[:parent_id]).to be_nil
    end

    it 'creates directory with parent' do
      post api_v1_directories_url, params: directory_with_parent_params
      expect(response.parsed_body.with_indifferent_access[:name]).to eq("child")
      expect(response.parsed_body.with_indifferent_access[:parent_id]).to eq(parent.id)
    end
  end
end
