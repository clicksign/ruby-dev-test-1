# frozen_string_literal: true

require 'rails_helper'

describe FileItemDeleteAction, type: :class do
  context 'when send nonexistent file_item id' do
    it do
      expect do
        described_class.new.perform(0)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when send exists file_item id' do
    let(:file_item) { create(:file_item) }

    it do
      expect do
        described_class.new.perform(file_item.id)
      end.to change(FileItemRecord, :count).by(0)
    end
  end
end
