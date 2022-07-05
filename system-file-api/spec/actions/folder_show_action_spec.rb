# frozen_string_literal: true

require 'rails_helper'

describe FolderShowAction, type: :class do
  context 'when folder id not exists' do
    it do
      expect do
        described_class.new.perform(0)
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'when folder exists' do
    let(:folder) { create(:folder) }

    it do
      result = described_class.new.perform(folder.id)
      expect(result[:folder].id).to eq(folder.id)
    end
  end
end
