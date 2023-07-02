require 'rails_helper'

RSpec.describe Api::VersionOne::ArchivesController, type: :controller do
  include Devise::Test::ControllerHelpers

  let!(:user)      { create(:user) }
  let!(:directory) { create(:directory, created_by_id: user.id) }
  let!(:archive)   { create(:archive, directory_id: directory.id, created_by_id: user.id) }

  before do
    allow(controller).to receive(:authenticate_user!).and_return(true)
    allow(controller).to receive(:current_user) { user }
  end

  describe 'GET #index' do
    it 'should list all archives' do
      get :index
      body = JSON.parse(response.body)
      
      expect(body['archives']['pagination']['per_page']).to eq(20)
    end
  end

  describe 'POST #create' do
    it 'should create a archive' do
      post :create, params: { archive: { name: "test archive", created_by_id: user.id, directory_id: directory.id} }
      body = JSON.parse(response.body)
      
      expect(body['archive']['created_by_id']).to eq(user.id)
    end
  end

  describe 'GET #show' do
    it 'should exhibit an archive' do
      get :show, params: {id: archive.id}
      body = JSON.parse(response.body)

      expect(body['archive']['id']).to eq(archive.id)
    end
  end

  describe 'PATCH/PUT #update' do
    before do
      @params = { id: archive.id, archive: { name: "updated archive"}}
    end

    it 'should update a archive' do
      put :update, params: @params
      body = JSON.parse(response.body)

      expect(body['archive']['name']).to eq(@params[:archive][:name])
    end
  end

  describe 'DELETE #destroy' do
    it 'should delete a archive' do
      delete :destroy, params: {id: archive.id}
      body = JSON.parse(response.body)

      expect(body['error']).to eq(false)
    end
  end
end