require 'rails_helper'

RSpec.describe V1::FoldersController, type: :controller do    

  let(:valid_folder_params) do 
    {
      data: {        
        type: 'folders',
        attributes: {
          name: Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3)
        }
      }
    }
  end

  let(:invalid_folder_params) do {    
      data: {        
        type: 'folders',
        attributes: {
          name: nil
        }
      }
    }
  end

  let(:acceptable_header) {'application/vnd.api+json'} 
   
  let(:folder) {Folder.first}

  context 'request with different headers' do
    it 'GET /v1/folders and return 406 status code (NOT ACCEPTABLE)' do
      get :index
      expect(response).to have_http_status(:not_acceptable)
    end

    it 'GET /v1/folders and return 200 status code (ACCEPTABLE)' do
      request.accept = acceptable_header
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'GET v1/folders/:id' do      
      request.accept = acceptable_header
      get :show, params: {id: folder.id}
      response_body = JSON.parse(response.body)
      expect(response_body.fetch('data').fetch('id')).to eq(folder.id.to_s)
    end
  end

  context 'requests with valid parameters' do
    context 'request with no existing name' do
      it 'POST v1/folders/' do        
        request.accept = acceptable_header
        post :create, params: valid_folder_params
        expect(response).to have_http_status(:created)
      end
    end

    context 'request with existing name' do
      it 'POST v1/folders/' do
        existing_folder = Folder.first
        request.accept = acceptable_header
        valid_folder_params[:data][:attributes][:name] = existing_folder.name        
        post :create, params: valid_folder_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    it 'PATCH v1/folders/:id' do      
      request.accept = acceptable_header      
      name = folder.name            
      valid_folder_params[:data][:id] = folder.id.to_s
      valid_folder_params[:data][:attributes][:name] = Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3)
      patch :update, params: { id: folder.id, data: valid_folder_params[:data] }
      response_body = JSON.parse(response.body)
      expect(response_body.fetch('data').fetch('attributes').fetch('name')).to_not eq(name)
    end

    it 'DELETE v1/folders/:id' do      
      request.accept = acceptable_header              
      delete :destroy, params: { id: folder.id }      
      expect(response).to have_http_status(:no_content)
    end
  end

  context "POST requests with invalid parameters" do
    it 'POST v1/folders/' do      
      request.accept = acceptable_header
      post :create, params: invalid_folder_params
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end    
end