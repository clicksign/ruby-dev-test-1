# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DirectoryInteraction::Create do
  let(:directory_interaction) { described_class.run!(params) }

  let(:dirname) { Faker::File.dir(segment_count: 1) }
  let(:directory_id) { nil }
  let(:params) do
    {
      dirname: dirname,
      directory_id: directory_id
    }
  end

  context 'when trying to create a directory without a dirname' do
    let(:dirname) { '' }

    it 'return error' do
      expect { directory_interaction }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end

  context 'when trying to create a directory with parent_id invalid' do
    let!(:directory_id) { 'ipsum lorem' }

    it 'return error' do
      expect { directory_interaction }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end

  context 'when to create a directory' do
    it 'return success' do
      expect { directory_interaction }.to change { Directory.count }.by(1)
      expect(Directory.count).to eq(1)
    end
  end

  context 'when to create a directory with subdirectories' do
    let!(:directory) { create(:directory) }
    let!(:directory_id) { directory.id }

    it 'return success' do
      expect { directory_interaction }.to change { Directory.count }.by(1)
      expect(Directory.count).to eq(2)
      expect(directory.subdirectories.count).to eq(1)
    end
  end
end
