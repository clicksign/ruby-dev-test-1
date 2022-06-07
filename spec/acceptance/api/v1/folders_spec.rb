require 'acceptance_helper'
require 'rails_helper'

resource "Folder" do
  explanation "Folder API"

  # headers
  header "Accept", "application/json"
  header "Content-Type", "application/json"
  header "Host", "localhost:3000"

  let(:folder) { create(:folder, :with_sub_folders, parent: parent.id) }
  let(:parent) { create(:folder) }

  # data population
  before do
    2.times do |t|
      create(:folder, name: "Folder #{t}", parent: parent)
    end
  end

  # example object for show, update and destroy
  let(:folder) do
    create(:folder, :with_sub_folders, parent_id: parent.id)
  end

  # object id alias
  let(:id) { folder.id }

  # requests

  # index
  get 'api/v1/folders' do
    # simulates a request
    example_request "Index" do
      expect(response_status).to eq(200)
      #expect(response_body).to match_json_schema("folder/index")
    end
  end

  # show
  get 'api/v1/folders/:id' do
    # simulates a request
    example_request "Show" do
      expect(response_status).to eq(200)
      #expect(response_body).to match_json_schema("folder")
    end
  end

  get 'api/v1/folders/:id/sub_folders' do
    # simulates a request
    example_request "SubFolders" do
      expect(response_status).to eq(200)
      #expect(response_body).to match_json_schema("folder")
    end
  end

  # create
  post 'api/v1/folders' do
    # list parameters
    parameter :name,        with_example: "Folder x", required: true,  type: :string
    parameter :permission,  with_example: 777,        required: true,  type: :integer
    parameter :parent_id,   with_example: 1,          required: false, type: :integer

    # set params to request simulation
    let(:name) { folder.name }
    let(:permission) { folder.permission }
    let(:folder) { create(:folder) }

    # set request payload
    let(:raw_post) { { folder: params }.to_json }

    # simulates a request
    example_request "Create" do
      expect(response_status).to eq(201)
      #expect(response_body).to match_json_schema("folder")
    end
  end

  # update
  put 'api/v1/folders/:id' do

    # list parameters
    parameter :name,        with_example: "Folder x", required: true,  type: :string
    parameter :permission,  with_example: 777,        required: true,  type: :integer
    parameter :parent_id,   with_example: 1,          required: false, type: :integer

    # set params to request simulation
    let(:name) { folder.name }
    let(:permission) { folder.permission }
    let(:folder) { create(:folder) }

    # set request payload
    let(:raw_post) { { folder: params }.to_json }

    # simulates a request
    example_request "Update" do
      expect(response_status).to eq(200)
      #expect(response_body).to match_json_schema("folder")
    end
  end


  # destroy
  delete 'api/v1/folders/:id' do
    # simulates a request
    example_request "Destroy" do
      expect(response_status).to eq(204)
    end
  end

end
