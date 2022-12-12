# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArchiveInteraction::Create do
  let(:archive_interaction) { described_class.run!(params) }

  let(:directory) { create(:directory) }
  let(:directory_id) { directory.id }
  let(:document) { File.open(Rails.root.join('spec/files/first_file.txt')) }
  let(:params) do
    {
      directory_id: directory_id,
      document: document
    }
  end

  context 'when trying to create a archive without a directory' do
    let(:directory_id) { nil }

    it 'return error' do
      expect { archive_interaction }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end

  context 'when trying to create a archive without a document' do
    let(:document) { nil }

    it 'return error' do
      expect { archive_interaction }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end

  context 'when trying to create a archive content size invalid' do
    let(:document) { File.open(Rails.root.join('spec/files/lorem_ipsum.txt')) }

    it 'return error' do
      expect { archive_interaction }.to raise_error(ActiveInteraction::InvalidInteractionError)
    end
  end

  context 'when to create a document' do
    it 'return success' do
      expect(Archive.count).to eq(0)
      expect { archive_interaction }.to change { Archive.count }.by(1)
      archive = Archive.last
      expect(archive.document.attached?).to be_truthy
      expect(archive.document.attached?).to be_truthy
      expect(archive.name).to eq('first_file')
      expect(archive.size).to eq(document.size)
    end
  end
end
