require 'rails_helper'

RSpec.describe 'Validation CRUD with the folders' do

  describe "create a new folder with request" do
    let!(:new_folder) { FactoryBot.build(:folder) }
    before do 
      post("/api/v1/folders",
        params: {
          name: new_folder["name"],
          parent_folder_id: new_folder["parent_folder_id"],
          files: new_folder["files"]
        }
      )
    end

    it "should possible to create a new folder" do
      expect(response).to have_http_status(:created)
    end
  end
  
  describe 'get all folders existents', type: :request do 
    let!(:folders) { FactoryBot.create_list(:folder, 10) }
    
    before { get '/api/v1/folders' }

    it 'should return all folders' do 
      expect(JSON.parse(response.body).size).to eq(10)
    end

    it 'should return http status code 200' do 
      expect(response).to have_http_status(:success)
    end
  end

  describe 'show specific folder', type: :request do
    let!(:requested_folder) { FactoryBot.create(:folder) }

    before { get "/api/v1/folders/#{requested_folder.id}" }
    
    it 'should return the requisited folder' do
      expect(response.body).to eq(requested_folder.to_json)
    end
      
    it 'should return http status code 200' do    
      expect(response).to have_http_status(:success)
    end
  end

  describe "update specific folder", type: :request do 
    let!(:requested_folder) { FactoryBot.create(:folder) }

    describe "rename a folder" do
      before do 
        put(
          "/api/v1/folders/#{requested_folder.id}", 
          params: { 
            name: 'Documents' 
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

    describe "move a folder to new folder with sucess" do
      let!(:new_folder) { FactoryBot.create(:folder) }
      before do
        put(
          "/api/v1/folders/#{requested_folder.id}",
          params: {
              parent_folder_id: new_folder.id
          }
        )
      end
      
      it 'should move to new parent folder' do
        expect(JSON.parse(response.body)["parent_folder_id"]).to eq(new_folder.id)
      end

      it 'should return sucess with status 200' do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "delete folder with request" do    
    it "destroys a specific folder" do
      folder = Folder.create!(name: "Test")
      expect { 
        delete "/api/v1/folders/#{folder.id}"
      }.to change(Folder, :count).by(-1)
    end
  end  

end