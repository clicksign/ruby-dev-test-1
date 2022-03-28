require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'validations' do
    let(:folder) { build_stubbed(:folder) }
    let(:invalid_folder) { build_stubbed(:folder, name: nil) }

    it 'is valid with a name' do
      expect(folder).to be_valid
    end

    it 'is not valid without a name' do
      expect(invalid_folder).to_not be_valid
    end
  end

  describe 'associations' do

    context "folders " do
      let(:parent_folder) { create(:folder) }
      let(:child_folder1) { create(:folder, parent_folder: parent_folder) }
      let(:child_folder2) { create(:folder, parent_folder: parent_folder) }
      let(:child_folder3) { create(:folder) }

      it 'can have many subfolders', :aggregate_failures do
        expect(parent_folder.subfolders).to eq([child_folder1, child_folder2])
        expect(parent_folder.subfolders).not_to include(child_folder3)
      end

      it 'can have one parent folder' do
        expect(child_folder1.parent_folder).to be(parent_folder)
      end

      it 'can have none parent folder', :aggregate_failures do
        expect(child_folder3.parent_folder).to be(nil)
        expect(child_folder3).to be_valid
      end
    end
  end

  describe 'has attached files' do
    let(:folder) { create(:folder) }

    it 'can have none files' do
      expect(folder.files).to be_empty
    end

    it 'can have many files', :aggregate_failures do
      folder.files.attach(io: File.open(Rails.root.join('spec/fixtures/sample_file')), filename: 'sample_file')
      folder.files.attach(io: File.open(Rails.root.join('spec/fixtures/sample_file2')), filename: 'sample_file2')

      expect(folder.files).to be_attached
      expect(folder.files.count).to be(2)
    end

  end
end
