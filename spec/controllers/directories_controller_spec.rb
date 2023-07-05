require 'rails_helper'

RSpec.describe DirectoriesController, type: :controller do
  describe 'POST #create' do
    context 'with valid parameters' do
      it 'creates a new directory' do
        directory_params = FactoryBot.attributes_for(:directory)

        expect {
          post :create, params: { directory: directory_params }
        }.to change(Directory, :count).by(1)
      end

      it 'redirects to directories index' do
        directory_params = FactoryBot.attributes_for(:directory)

        post :create, params: { directory: directory_params }

        expect(response).to redirect_to(directories_path)
      end

      it 'sets a flash notice' do
        directory_params = FactoryBot.attributes_for(:directory)

        post :create, params: { directory: directory_params }

        expect(flash[:notice]).to eq('Directory Created')
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new directory' do
        directory_params = FactoryBot.attributes_for(:directory, name: nil)

        expect {
          post :create, params: { directory: directory_params }
        }.not_to change(Directory, :count)
      end
    end

    context 'with parent_id' do
      it 'creates a new directory within another directory' do
        parent_directory = FactoryBot.create(:directory)
        directory_params = FactoryBot.attributes_for(:directory, parent_id: parent_directory.id)

        expect {
          post :create, params: { directory: directory_params }
        }.to change(parent_directory.children, :count).by(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the directory and its dependencies' do
      directory = FactoryBot.create(:directory)
      child_directory = FactoryBot.create(:directory, parent_id: directory.id)
      aws_file = FactoryBot.create(:aws_file, directory_id: directory.id)

      expect {
        delete :destroy, params: { id: directory.id }
      }.to change(Directory, :count).by(-2)

      expect(AwsFile.where(id: aws_file.id)).not_to exist
    end

    it 'redirects to directories path' do
      directory = FactoryBot.create(:directory)

      delete :destroy, params: { id: directory.id }

      expect(response).to redirect_to(directories_path)
    end

    it 'sets a flash notice' do
      directory = FactoryBot.create(:directory)

      delete :destroy, params: { id: directory.id }

      expect(flash[:notice]).to eq('Directory Deleted')
    end
  end
end
