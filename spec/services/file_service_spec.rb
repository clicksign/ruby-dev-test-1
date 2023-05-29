# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FileService do
  describe '#create' do
    let(:params) do
      {
        path: 'spec/fixtures/files/file.txt',
        data: 'base64_encoded_file',
        type:
      }
    end
    let(:file_name) { 'file.txt' }
    let(:dir_name) { 'spec/fixtures/files' }
    let(:file_service) { described_class.new(params) }
    let(:folder) { FolderService.new({ path: dir_name }).create }

    before do
      allow(Base64).to receive(:strict_decode64).and_return('decoded_file')
    end

    context 'when file type is blob' do
      let(:type) { 'blob' }

      before do
        allow(StringIO).to receive(:open).and_return('io_object')
      end

      it 'creates Blob file' do
        expect { file_service.create }.to change(FileModule::Blob, :last).to(
          have_attributes(name: file_name, file_data: 'io_object', folder:)
        )
      end
    end

    context 'when file is S3' do
      let(:type) { 's3' }

      it 'creates s3 file' do
        expect { file_service.create }.to change(FileModule::S3, :last).to(
          have_attributes(name: file_name, file_data: nil, attachment: have_attributes(service_name: 'amazon'),
                          folder:)
        )
      end
    end

    context 'when file is Local' do
      let(:type) { 'local' }

      it 'creates local file' do
        expect { file_service.create }.to change(FileModule::Local, :last).to(
          have_attributes(name: file_name, file_data: nil, attachment: have_attributes(service_name: 'local'),
                          folder:)
        )
      end
    end
  end

  describe '#index' do
    let(:file_service) { described_class.new(params) }
    let(:folder) { create(:folder) }
    let(:file) { create(:file_local, folder:) }

    context 'when searching by name' do
      let(:params) { { name: file.name } }

      it 'fetches files, by name, matching the query' do
        expect(file_service.list_by_name).to eq([file])
      end
    end
  end
end
