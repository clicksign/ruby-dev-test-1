# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Directory do
  it { is_expected.to have_many(:file_items) }
  it { is_expected.to have_many(:subdirectories) }
  it { is_expected.to belong_to(:parent).optional(true) }
  it { is_expected.to have_one_attached(:content) }

  context 'when create' do
    it 'change model' do
      expect do
        create(:directory)
      end.to change(described_class, :count).by_at_least(1)
    end

    it 'is attached a file' do
      directory = create(:directory)
      directory.content.attach(
        io: File.open('spec/fixtures/clicksign.png'),
        filename: 'clicksign.png',
        content_type: 'application/png'
      )
      expect(directory.content).to be_attached
    end
  end
end
