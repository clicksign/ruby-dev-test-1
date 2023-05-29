RSpec.describe Storage, type: :model do
  describe 'associations' do
    it { should belong_to(:folder) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:folder_id) }
  end

  describe 'path' do
    let(:folder) { create(:folder, name: 'folder_1') }
    let(:storage) { create(:file_local, name: 'file.txt', folder: folder) }

    it 'returns the correct path' do
      expect(storage.path).to eq('folder_1/file.txt')
    end
  end
end
