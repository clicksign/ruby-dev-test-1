# frozen_string_literal: true

RSpec.describe Storage do
  describe 'associations' do
    it { is_expected.to belong_to(:folder) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:folder_id) }
  end

  describe 'path' do
    let(:folder) { create(:folder, name: 'folder_1') }
    let(:storage) { create(:file_local, name: 'file.txt', folder:) }

    it 'returns the correct path' do
      expect(storage.path).to eq('folder_1/file.txt')
    end
  end
end
