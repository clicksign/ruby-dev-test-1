require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'Model validations' do
    let(:folder) { build(:folder) }

    context 'When save fails' do
      it 'Should not save folder without name' do
        folder = Folder.new

        expect(folder).not_to be_valid
        expect(folder.errors[:name]).to eq(["can't be blank"])
      end

      it 'Should not save folder with duplicate names' do
        folder.save!
        duplicated_folder = build(:folder)

        expect(duplicated_folder).not_to be_valid
        expect(duplicated_folder.errors[:name]).to eq(['has already been taken'])
      end

      it 'Should not save folder with self reference' do
        folder.save!
        folder.parent = folder

        expect(folder).not_to be_valid
        expect(folder.errors[:self_reference]).to eq(['Folder must not self-reference'])
      end
    end

    context 'When is successfully saved' do
      it 'Should save a folder' do
        expect(folder).to be_valid
      end

      it 'Should save a folder with sub_folders' do
        sub_folder = build(:folder, :sub_folder)
        expect(sub_folder).to be_valid
      end
    end
  end
end
