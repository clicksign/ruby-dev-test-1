# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Archive, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(100) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:folder_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:folder).optional }
  end

  describe 'callbacks' do
    describe '#update_path' do
      let(:root) { create(:folder, name: 'root') }
      let(:file) { create(:archive, name: 'file') }

      it 'when the file into root' do
        file.update(name: 'file_1')

        expect(file.path).to eq('/')
      end

      it 'when the file into folder' do
        file.update(folder: root)

        expect(file.path).to eq('/root/')
      end
    end
  end
end
