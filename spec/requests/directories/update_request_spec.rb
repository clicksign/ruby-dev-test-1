RSpec.describe "/api/v1/directories", type: :request do
  describe "updates directory" do
    let(:parent) { Directory.create(name: "root") }
    let(:new_parent) { Directory.create(name: "root 2") }
    let(:directory) { Directory.create(name: "child 1", parent_id: parent.id) }
    let(:directory_params) { { name: "child one", parent_id: new_parent.id } }

    it 'update a directory' do
      put api_v1_directory_url(id: directory.id), params: directory_params

      expect(response).to have_http_status(:ok)
      expect(response.parsed_body.with_indifferent_access[:name]).to eq("child one")
      expect(response.parsed_body.with_indifferent_access[:parent_id]).to eq(new_parent.id)
    end
  end
end
