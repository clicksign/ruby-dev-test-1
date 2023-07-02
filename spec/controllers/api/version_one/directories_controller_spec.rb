require 'rails_helper'

RSpec.describe Api::VersionOne::DirectoriesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:user)         { create(:user)}
  let!(:directory)    { create(:directory, name: "test directory", created_by_id: user.id)}
  let!(:subdirectory) { create(:directory, name: "subdirectory", parent_id: directory.id)}

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user) { user }
  end

  describe 'GET #index' do
    it 'should list all directories' do
      get :index
      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body['directories']['pagination']['per_page']).to eq(20)
    end
  end

  describe 'POST #create' do
    it 'should create a directory' do
      post :create, params: { directory: { name: "test directory"}}
      body = JSON.parse(response.body)
      
      expect(response.status).to eq(200)
      expect(body['directory']['created_by_id']).to eq(user.id)
    end
  end

  describe 'GET #show' do
    it 'should exhibit a directory' do
      get :show, params: {id: directory.id}
      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body['directory']['id']).to eq(directory.id)
    end
  end

  describe 'PATCH/PUT #update' do
    before do
      @params = { id: directory.id, directory: { name: "updated directory" }}
    end

    it 'should update a directory' do
      put :update, params: @params
      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body['directory']['name']).to eq(@params[:directory][:name])
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete a directory' do
      delete :destroy, params: {id: subdirectory.id}
      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body['error']).to eq(false)
    end
  end

  describe 'GET #get_subdirectories' do
    it 'should list all subdirectories from directory' do
      get :get_subdirectories, params: {id: directory.id}
      body = JSON.parse(response.body)

      expect(response.status).to eq(200)
      expect(body['subdirectories']).to be_present
    end
  end
end