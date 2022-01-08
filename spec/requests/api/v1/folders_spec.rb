require 'rails_helper'



RSpec.describe 'Handle folders' do
  
  describe 'get all folders', type: :request do 
    let!(:folders) { FactoryBot.create_list(:folder, 10) }
    
    before { get '/api/v1/folders' }

    it 'should return all folders' do 
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'should return http status code 200' do 
      expect(response).to have_http_status(:success)
    end
  end

  describe 'show folder', type: :request do
    let!(:requested_folder) { FactoryBot.create(:folder) }

    before { get "/api/v1/folders/#{requested_folder.id}" }
    
    it 'should return the requested folder' do
      expect(response.body).to eq(requested_folder.to_json)
    end
      
    it 'should return http status code 200' do    
      expect(response).to have_http_status(:success)
    end
  end

  describe "update folder", type: :request do 
    let!(:requested_folder) { FactoryBot.create(:folder) }

    describe "rename folder" do
      before do 
        put(
          "/api/v1/folders/#{requested_folder.id}", 
          params: { 
            folder: { 
              name: 'Documents' 
            }
          } 
        )
      end

      it 'should return the renamed folder' do
        expect(JSON.parse(response.body)).to have_key("name")
      end

      it 'should change the folder name' do
        expect(JSON.parse(response.body)["name"]).to eq("Documents")
      end

      it 'should return http status 204' do
        expect(response).to have_http_status(:success)
      end
    end

    describe "move folder" do
      let!(:new_folder) { FactoryBot.create(:folder) }
      before do
        put(
          "/api/v1/folders/#{requested_folder.id}",
          params: {
            folder: {
              parent_folder_id: new_folder.id
            }
          }
        )
      end
      
      it 'should move to new parent folder' do
        expect(JSON.parse(response.body)["parent_folder_id"]).to eq(new_folder.id)
      end

      it 'should return http status 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "delete folder" do    
    it "destroys the requested folder" do
      folder = Folder.create!(name: "Test")
      expect { 
        delete "/api/v1/folders/#{folder.id}"
      }.to change(Folder, :count).by(-1)
    end
  end

  describe "create folder" do
    let!(:new_folder) { FactoryBot.build(:folder) }
    before do 
      post("/api/v1/folders",
        params: {
          folder: {
            name: new_folder["name"],
            parent_folder_id: new_folder["parent_folder_id"],
            files: new_folder["files"]
          }
        }
      )
    end

    it "should create a new folder" do
      expect(response).to have_http_status(:created)
    end
  end

end