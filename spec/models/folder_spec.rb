require 'rails_helper'

RSpec.describe Folder, type: :model do
  let(:folder) { build(:folder) }

  context 'associations' do
    it { should belong_to(:parent).optional }
  end
  
  context 'validations' do 
    it { expect(folder).to validate_presence_of(:name) }

    it 'cannot be descendant of itself' do
      folder1 = create(:folder, name: 'folder1')
      folder11 = create(:folder, name: 'folder11', parent: folder1)
      folder111 = create(:folder, name: 'folder111', parent: folder11)

      expect {
        folder1.update!(parent: folder1)
      }.to raise_error(ActiveRecord::RecordInvalid).with_message('Validation failed: Folder cannot be a descendant of itself.')

      expect { folder111.update!(parent: folder1) }.to_not raise_error
    end
  end
end
