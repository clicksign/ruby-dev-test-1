# frozen_string_literal: true
require 'rails_helper'

RSpec.describe FolderService do
  describe '#create' do
    let(:params) do
      {
        path: 'spec/fixtures/files/folder'
      }
    end
    let(:folder_service) { FolderService.new(params) }

    context 'when folder does not exist' do
      it 'creates folder' do
        expect{folder_service.create}.to change{Folder.last}.to(
          have_attributes(name: File.basename(params[:path]), path: params[:path], parent_folder: be_present)
        )
      end
    end

    context 'when folder exists' do
      it 'does not create folder' do
        folder_service.create
        expect{folder_service.create}.not_to change{Folder.count}
      end
    end
  end
end