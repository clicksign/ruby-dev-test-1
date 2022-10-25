require 'rails_helper'

RSpec.describe LocalFilesController, type: :request do
  describe "POST .create" do
    it 'creates a new folder' do
      folder = create(:folder)
      params = { local_file: attributes_for(:local_file) }

      expect do
        post folder_local_files_url(folder_id: folder.id, params:)
      end.to change(LocalFile, :count).by(1)
         .and change(Medium, :count).by(1)
    end
  end
end
