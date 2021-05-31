require 'rails_helper'

RSpec.describe Api::V1::DirectoriesController, type: :controller do
  let!(:root_dir) { Directory.find_by_name('root') }

  describe 'GET #index' do
    let(:file_1) { fixture_file_upload('sample.jpg') }
    let(:file_2) { fixture_file_upload('sample.mp3') }

    let!(:directory_1) { create(:directory, name: 'Insertus') }
    let!(:directory_2) { create(:directory, name: 'Warsaw', parent_id: directory_1.id, files: [file_1, file_2]) }

    def serialized_subdirectory_parsed(directory)
      JSON.parse(SubdirectorySerializer.new(directory).to_json)
    end

    def serialized_file_parsed(file)
      JSON.parse(FileSerializer.new(file).to_json)
    end

    it 'show directories, subdirectories and files' do
      get :index

      expect(response).to have_http_status(:ok)

      json_body = JSON.parse(response.body)

      # root
      expect(json_body['data'][0]['attributes']).to include('name' => 'root')
      expect(json_body['data'][0]['attributes']).to include('ancestry' => nil)
      expect(json_body['data'][0]['attributes']).to include('files' => [])
      expect(json_body['data'][0]['attributes']).to include('subdirectories' => [serialized_subdirectory_parsed(directory_1)])

      # directory_1
      expect(json_body['data'][1]['attributes']).to include('name' => 'Insertus')
      expect(json_body['data'][1]['attributes']).to include('ancestry' => '1')
      expect(json_body['data'][1]['attributes']).to include('files' => [])
      expect(json_body['data'][1]['attributes']).to include('subdirectories' => [serialized_subdirectory_parsed(directory_2)])

      # directory_2
      expect(json_body['data'][2]['attributes']).to include('name' => 'Warsaw')
      expect(json_body['data'][2]['attributes']).to include('ancestry' => '1/2')
      expect(json_body['data'][2]['attributes']).to include('files' => [
        serialized_file_parsed(directory_2.files.first),
        serialized_file_parsed(directory_2.files.last)
      ])
      expect(json_body['data'][2]['attributes']).to include('subdirectories' => [])
    end
  end

  describe 'POST #create' do
    let!(:directory) { create(:directory, name: 'Warsaw') }
    subject { post :create, params: { directory: params } }

    context 'when creating without parent id' do
      let(:params) { { name: 'Insertus' } }

      it 'creates the directory in root' do
        expect { subject }.to change(Directory, :count).by(1)

        expect(response).to have_http_status(:created)
        json_body = JSON.parse(response.body)

        expect(json_body['data']['attributes']).to include('name' => 'Insertus')
        expect(json_body['data']['attributes']).to include('ancestry' => root_dir.id.to_s)
      end
    end

    context 'when creating with valid parent id' do
      let(:params) { { name: 'Insertus', parent_id: directory.id } }

      it 'creates the directory in directory' do
        expect { subject }.to change(Directory, :count).by(1)

        expect(response).to have_http_status(:created)
        json_body = JSON.parse(response.body)

        expect(json_body['data']['attributes']).to include('name' => 'Insertus')
        expect(json_body['data']['attributes']).to include('ancestry' => "1/#{directory.id}")
      end
    end

    context 'when creating with invalid parent id' do
      let(:params) { { name: 'Insertus', parent_id: 999_999 } }

      it 'raise exception' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when creating with files' do
      let(:file) { fixture_file_upload('sample.jpg') }
      let(:params) { { name: 'Insertus', files: [file] } }

      it 'creates the directory in root, with files into' do
        expect { subject }.to change(Directory, :count).by(1)

        expect(response).to have_http_status(:created)
        json_body = JSON.parse(response.body)

        expect(json_body['data']['attributes']).to include('name' => 'Insertus')
        expect(json_body['data']['attributes']).to include('ancestry' => root_dir.id.to_s)

        file_attributes = json_body['data']['attributes']['files'][0]['data']['attributes']
        expect(file_attributes).to include('filename' => file.original_filename)
        expect(file_attributes).to include('byte_size' => file.size)
      end
    end
  end

  describe 'PUT #update' do
    let!(:another_directory) { create(:directory, name: 'Warsaw') }
    let!(:directory) { create(:directory, name: 'Insertus') }
    subject { patch :update, params: { id: directory.id, directory: params } }

    context 'when updating without parent id' do
      let(:params) { { name: 'insertus' } }

      it 'updates directory' do
        expect { subject }.to change(Directory, :count).by(0)

        expect(response).to have_http_status(:ok)
        json_body = JSON.parse(response.body)

        expect(json_body['data']['attributes']).to include('name' => 'insertus')
        expect(json_body['data']['attributes']).to include('ancestry' => root_dir.id.to_s)
      end
    end

    context 'when creating with valid parent id' do
      let(:params) { { name: 'insertuS', parent_id: another_directory.id } }

      it 'creates the directory in directory' do
        expect { subject }.to change(Directory, :count).by(0)

        expect(response).to have_http_status(:ok)
        json_body = JSON.parse(response.body)

        expect(json_body['data']['attributes']).to include('name' => 'insertuS')
        expect(json_body['data']['attributes']).to include('ancestry' => "1/#{another_directory.id}")
      end
    end

    context 'when updating with invalid parent id' do
      let(:params) { { name: 'insertus', parent_id: 999_999 } }

      it 'raise exception' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when updating with files' do
      let(:file) { fixture_file_upload('sample.jpg') }
      let(:params) { { files: [file] } }

      it 'insert files into directory' do
        expect { subject }.to change(Directory, :count).by(0)

        expect(response).to have_http_status(:ok)
        json_body = JSON.parse(response.body)

        expect(json_body['data']['attributes']).to include('name' => 'Insertus')
        expect(json_body['data']['attributes']).to include('ancestry' => root_dir.id.to_s)

        file_attributes = json_body['data']['attributes']['files'][0]['data']['attributes']
        expect(file_attributes).to include({ 'filename' => file.original_filename })
        expect(file_attributes).to include({ 'byte_size' => file.size })
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:directory) { create(:directory, name: 'Insertus') }

    let!(:directory_id) { directory.id }
    subject { delete :destroy, params: { id: directory_id } }

    context 'when directory exists' do
      it 'removes the directory' do
        expect { subject }.to change(Directory, :count).by(-1)

        expect(response).to have_http_status(:ok)
        expect { directory.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when directory exists with files' do
      let!(:directory) { create(:directory, :with_files) }

      it 'removes directory and your files' do
        expect(ActiveStorage::Attachment.count).to eq 2

        expect { subject }.to change(Directory, :count).by(-1)
                                                       .and change(ActiveStorage::Attachment, :count).by(-2)

        expect(response).to have_http_status(:ok)
      end
    end

    context 'when directory exists with children' do
      let!(:directory_2) { create(:directory, parent_id: directory.id) }

      it 'removes directory and your children' do
        expect { subject }.to change(Directory, :count).by(-2)

        expect(response).to have_http_status(:ok)
        expect { directory.reload }.to raise_error(ActiveRecord::RecordNotFound)
        expect { directory_2.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'when directory doesnt exists' do
      let(:directory_id) { 999_999 }

      it 'raise exception' do
        expect { subject }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
