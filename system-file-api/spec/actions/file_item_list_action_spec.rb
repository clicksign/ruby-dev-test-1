# frozen_string_literal: true

require 'rails_helper'

describe FileItemListAction, type: :class do
  let(:folder) { create(:folder) }

  context 'when folder has n items' do
    before do
      create_list(:file_item, 5, folder: folder)
    end

    it do
      result = described_class.new.perform(folder.id)
      expect(result[:file_items].length).to eq(5)
    end
  end

  context 'when folder has no items' do
    let(:folder) { create(:folder) }

    it do
      result = described_class.new.perform(folder.id)
      expect(result[:file_items].length).to eq(0)
    end
  end
end
