# frozen_string_literal: true

require 'rails_helper'

describe FileItemCreateAction, type: :class do
  let(:content) { blob_file(Rails.root.join('db/files/postgres.png'), 'postgres.png', 'image/png') }
  let(:folder) { create(:folder) }

  context 'when send invalid input' do
    it 'with blank name' do
      result = described_class.new.perform(folder.id, attributes_for(:file_item, name: nil))
      expect(result[:errors][:name]).to include("can't be blank")
    end

    it 'with blank folder_id' do
      result = described_class.new.perform(nil, attributes_for(:file_item))
      expect(result[:errors][:folder_id]).to include("can't be blank")
    end

    it 'with blank content' do
      result = described_class.new.perform(folder.id, attributes_for(:file_item, content: nil))
      expect(result[:errors][:content]).to include("can't be blank")
    end

    it 'with nonexistent folder_id' do
      expect do
        described_class.new.perform(0, attributes_for(:file_item, content: content))
      end.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'when send valid input' do
    it do
      described_class.new.perform(folder.id, attributes_for(:file_item, name: 'New File Item',
                                                                        content: content))
      expect(FileItemRecord.count).to eq(1)
      expect(FileItemRecord.last.content.attached?).to eq(true)
    end
  end
end
