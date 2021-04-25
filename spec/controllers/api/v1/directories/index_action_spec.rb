require 'rails_helper'

describe Api::V1::DirectoriesController, type: :controller do
  describe 'When have created directories' do
    it 'should assigns directories' do
      directory = Directory.create(name: 'first directory')
      get :index
      expect(assigns(:directories)).to eq([directory])
    end

    it 'should render index' do
      get :index
      expect(response).to render_template("index")
    end
  end
end