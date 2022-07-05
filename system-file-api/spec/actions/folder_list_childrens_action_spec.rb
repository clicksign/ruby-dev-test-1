# frozen_string_literal: true

require 'rails_helper'

describe FolderListChildrensAction, type: :class do
  let(:folder) { create(:folder) }

  context 'when folder has n childrens' do
    before do
      create_list(:folder, 5, folder_id: folder.id)
    end

    it do
      result = described_class.new.perform(folder.id)
      expect(result[:folders].length).to eq(5)
    end
  end

  context 'when folder has no items' do
    let(:folder) { create(:folder) }

    it do
      result = described_class.new.perform(folder.id)
      expect(result[:folders].length).to eq(0)
    end
  end
end
