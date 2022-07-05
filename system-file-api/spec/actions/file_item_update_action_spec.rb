# frozen_string_literal: true

require 'rails_helper'

describe FileItemUpdateAction, type: :class do
  let(:content) { blob_file(Rails.root.join('db/files/postgres.png'), 'postgres.png', 'image/png') }
  let(:folder) { create(:folder) }
  let(:file_item) { create(:file_item, folder: folder) }

  context 'when send invalid input' do
    it 'with blank name' do
      result = described_class.new.perform(file_item.id, folder.id, attributes_for(:file_item, name: nil))
      expect(result[:errors][:name]).to include("can't be blank")
    end

    it 'with blank folder_id' do
      result = described_class.new.perform(file_item.id, nil, attributes_for(:file_item))
      expect(result[:errors][:folder_id]).to include("can't be blank")
    end

    it 'with nonexistent folder_id' do
      expect do
        described_class.new.perform(file_item.id, 0, attributes_for(:file_item, content: content))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'when send valid input' do
    it 'renames file item' do
      expect do
        described_class.new.perform(file_item.id, folder.id, attributes_for(:file_item, name: 'New File Item'))
        file_item.reload
      end.to change(file_item, :name)
    end

    it 'updates content' do
      new_content = blob_file(Rails.root.join('db/files/githubactions.png'), 'githubactions.png', 'image/png')
      expect do
        described_class.new.perform(file_item.id, folder.id, attributes_for(:file_item, content: new_content))
        file_item.reload
      end.to change { file_item.content.key }
    end
  end
end
