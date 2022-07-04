# frozen_string_literal: true

require 'rails_helper'

describe FolderDeleteAction, type: :class do
  context 'when send nonexistent folder id' do
    it do
      expect do
        described_class.new.perform(0)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when send valid folder id' do
    let(:folder) { create(:folder) }

    it do
      expect do
        described_class.new.perform(folder.id)
      end.to change(FolderRecord, :count).by(0)
    end
  end

  context 'when folder has childrens' do
    let(:folder) { create(:folder) }

    before do
      create(:file_item, folder: folder)
      create(:folder, folder_id: folder.id)
    end

    it do
      described_class.new.perform(folder.id)
      expect(FolderRecord.count).to eq(0)
      expect(FileItemRecord.count).to eq(0)
    end
  end
end
