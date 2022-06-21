# frozen_string_literal: true

require 'rails_helper'

describe FolderCreateAction, type: :class do
  context 'when send invalid input' do
    it 'with blank name' do
      result = described_class.new.perform(attributes_for(:folder, name: nil))
      expect(result[:errors][:name]).to include("can't be blank")
    end

    it 'with invalid folder_id' do
      result = described_class.new.perform(attributes_for(:folder, folder_id: 99))
      expect(result[:errors]).to eq('Parent folder not exists')
    end
  end

  context 'when send valid folder' do
    it do
      expect do
        described_class.new.perform(attributes_for(:folder, name: 'New Folder'))
      end.to change(FolderRecord, :count)
    end

    it 'with valid folder_id' do
      parent_folder = create(:folder)
      result = described_class.new.perform(attributes_for(:folder, name: 'New Folder', folder_id: parent_folder.id))
      expect(result.folder.folder_id).to eq(parent_folder.id)
    end
  end
end
