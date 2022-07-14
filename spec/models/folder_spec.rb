# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(100) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:parent_id) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:children) }
    it { is_expected.to belong_to(:parent).optional }
  end

  describe 'scopes' do
    describe '.roots' do
      let(:subject) { described_class.roots }
      let(:folder_1) { create(:folder, name: 'root_1') }
      let(:folder_2) { create(:folder, name: 'root_2') }

      context 'return root folders' do
        it { expect(subject).to eq([folder_1, folder_2]) }
      end

      context "doesn't return root folders" do
        before do
          folder_1.destroy!
          folder_2.destroy!
        end

        it { expect(subject).to eq([]) }
      end
    end
  end

  describe 'callbacks' do
    let(:root) { create(:folder, name: 'root') }
    let(:folder) { described_class.create(name: 'folder') }
    let(:subject) { described_class.roots }

    describe '#update_path' do
      it 'when the folder is root' do
        expect(folder.path).to eq('/')
      end
    end

    describe '#update_children_path' do
      it 'when the folder into second level' do
        folder.update(parent: root)

        expect(root.path).to eq('/')
        expect(folder.path).to eq('/root/')
      end

      it 'when the folder into third level' do
        third_lvl_folder = described_class.create(name: 'third_lvl_folder')
        folder.update(parent: root)
        third_lvl_folder.update(parent: folder)

        expect(root.path).to eq('/')
        expect(folder.path).to eq('/root/')
        expect(third_lvl_folder.path).to eq('/root/folder/')
      end

      it 'when the folder receive a child' do
        root.children << folder
        root.save!

        expect(root.path).to eq('/')
        expect(folder.path).to eq('/root/')
      end

      it 'when a second level folder change root' do
        other_root = described_class.create(name: 'other_root')
        root.children << folder
        root.save!

        other_root.children << folder
        other_root.save!

        expect(root.path).to eq('/')
        expect(other_root.path).to eq('/')
        expect(folder.path).to eq('/other_root/')
      end
    end
  end

  describe '.destroy' do
    let(:root) { create(:folder, name: 'root') }
    let(:folder_1) { described_class.create(name: 'folder_1', parent: root) }
    let(:folder_2) { described_class.create(name: 'folder_2', parent: folder_1) }

    it 'remove folder and children' do
      folder_1.destroy!

      expect(root.path).to eq('/')
      expect(described_class.count).to eq(1)
    end
  end
end
