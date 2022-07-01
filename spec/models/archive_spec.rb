require 'rails_helper'

RSpec.describe Archive, type: :model do
  describe 'Model validations' do
    let(:archive) { build(:archive) }

    context 'When save fails' do
      it 'Should not save archive without name' do
        archive = Archive.new

        expect(archive).not_to be_valid
        expect(archive.errors[:name]).to eq(["can't be blank"])
      end

      it 'Should not save archive without file' do
        archive = Archive.new(name: 'Archive 1')

        expect(archive).not_to be_valid
        expect(archive.errors[:file]).to eq(["can't be blank"])
      end

      it 'Should not save archive with duplicate names' do
        archive.save
        duplicated_archive = build(:archive, folder: archive.folder)

        expect(duplicated_archive).not_to be_valid
        expect(duplicated_archive.errors[:name]).to eq(['has already been taken'])
      end
    end

    context 'when is successfully saved' do
      it 'should validates archive' do
        expect(archive).to be_valid
      end
    end
  end
end
