# frozen_string_literal: true

require 'rails_helper'

describe FolderCreateAction, type: :class do
  context 'when send blank name' do
    it do
      create(:folder)
      result = described_class.new.perform(attributes_for(:folder, name: nil))
      expect(result[:errors][:name]).to include("can't be blank")
    end
  end

  context 'when send invalid parent_id' do
    it do
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
  end
end
