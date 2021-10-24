require 'rails_helper'

RSpec.describe Folder, type: :model do
  it { should validate_presence_of(:name) }
  it { should have_many(:child_folders) }
  it { should belong_to(:parent_folder).optional(true) }
  it { should have_many_attached(:archives) }

  describe '#is_root_folder?' do
    it 'a root folder' do
      folder = build(:folder, parent_folder: nil)
      expect(folder.is_root_folder?).to be(true)
    end

    it 'not a root folder' do
      folder = build(:folder, parent_folder: build(:folder))
      expect(folder.is_root_folder?).to be(false)
    end
  end
end
