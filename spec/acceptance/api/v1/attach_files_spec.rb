require 'acceptance_helper'
require 'rails_helper'

resource "Attach Files" do
  explanation "Files API"

  # headers
  header "Accept", "application/json"
  header "Content-Type", "application/json"
  header "Host", "localhost:3000"

  let(:attach_file) { create(:attach_file, folder: create(:folder)) }

  # data population
  before do
    2.times do |t|
      create(:attach_file, name: "File #{t}", folder: create(:folder))
    end
  end

  # example object for show, update and destroy
  let(:attach_file) { create(:attach_file, folder: create(:folder)) }

  # object id alias
  let(:id) { attach_file.id }

  # requests

  # show
  get 'api/v1/attach_files/:id' do
    # simulates a request
    example_request "Show" do
      expect(response_status).to eq(200)
    end
  end

  # create
  post 'api/v1/attach_files' do
    # list parameters
    parameter :name,         with_example: "Folder x", required: true,  type: :string
    parameter :file,         with_example: "",         required: true, type: :file
    parameter :folder_id,    with_example: 1,          required: true,  type: :integer

    # set params to request simulation
    let(:name)      { attach_file.name }
    let(:folder_id) { attach_file.folder_id }
    let(:file)      { Rack::Test::UploadedFile.new('spec/fixtures/blob.jpg', 'image/jpg') }
    # set request payload
    let(:raw_post)  { { attach_file: params }.to_json }

    # simulates a request
    example_request "Create" do
      expect(response_status).to eq(201)
    end
  end

  # update
  put 'api/v1/attach_files/:id' do

    # list parameters
    parameter :name,         with_example: "Folder x", required: true,  type: :string
    parameter :file,  with_example: "",         required: false, type: :file
    parameter :folder_id,    with_example: 1,          required: true,  type: :integer

    # set params to request simulation
    let(:name)      { attach_file.name }
    let(:folder_id) { attach_file.folder_id }
    let(:file)      { attach_file.file }

    # set request payload
    let(:raw_post) { { attach_file: params }.to_json }

    # simulates a request
    example_request "Update" do
      expect(response_status).to eq(200)
    end
  end


  # destroy
  delete 'api/v1/attach_files/:id' do
    # simulates a request
    example_request "Destroy" do
      expect(response_status).to eq(204)
    end
  end

end
