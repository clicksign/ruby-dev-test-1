require 'rails_helper'

describe Folder do
  describe "Parent Folder" do
    subject{ described_class.new(name: 'folder01') }
    
    context 'when the parent folder data is valid' do
      it 'return valid' do
        expect(subject).to be_valid
      end
    end

    context 'when the parent folder data is invalid' do
      it 'return invalid if without name' do
        subject.name = nil

        expect(subject).not_to be_valid
        expect(subject.errors[:name]).to eq(["can't be blank"])
      end

      it 'return invalid if duplicate names' do
        Folder.create!(name: "folder01")

        expect(subject).not_to be_valid
        expect(subject.errors[:name]).to eq(["has already been taken"])
      end
    end
  end

  describe "Children Folder" do
    subject{ described_class.new(name: 'folder02', parent: parent_folder) }

    let(:parent_folder) { Folder.create(name: "parent_folder") }
    
    context 'when the children folder data is valid' do
      it 'return valid' do
        expect(subject).to be_valid
      end
    end

    context 'when the children folder data is invalid' do
      it 'return invalid if without name' do
        subject.name = nil

        expect(subject).not_to be_valid
        expect(subject.errors[:name]).to eq(["can't be blank"])
      end

      it 'return invalid if duplicate names' do
        Folder.create!(name: "folder02", parent: parent_folder)

        expect(subject).not_to be_valid
        expect(subject.errors[:name]).to eq(["has already been taken"])
      end
    end
  end
end