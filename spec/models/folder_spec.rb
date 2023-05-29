# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:parent_folder).optional }
    it { is_expected.to have_many(:sub_folders) }
    it { is_expected.to have_many(:files) }
  end

  describe 'validations' do
    subject { build(:folder) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:parent_folder_id) }
  end

  describe 'callbacks' do
    describe 'before_save' do
      let(:folder) { build(:folder) }

      it 'sets the path' do
        folder.save!
        expect(folder.path).to eq(folder.name)
      end

      it 'sets the path for chained folders' do
        folder1 = create(:folder, parent_folder: folder)

        expect(folder1.path).to eq("#{folder.name}/#{folder1.name}")
      end
    end
  end

  describe '#move_to' do
    let(:folder) { create(:folder) }
    let(:new_parent_folder) { create(:folder) }

    it 'updates the parent_folder and saves the record' do
      folder.move_to(new_parent_folder)
      folder.reload
      expect(folder.parent_folder).to eq(new_parent_folder)
    end

    it 'updates the parent_folder and validates the new path' do
      folder.move_to(new_parent_folder)
      folder.reload
      expect(folder.path).to eq("#{new_parent_folder.name}/#{folder.name}")
    end

    it 'raises an cyclic error message if try to move a folder to one of his subfolders' do
      sub_folder = create(:folder, parent_folder: folder)
      expect { folder.move_to(sub_folder) }.to raise_error(FolderError, 'Cyclic operation')
    end

    it 'calls update_paths' do
      expect(folder).to receive(:update_paths)
      folder.move_to(new_parent_folder)
    end

    it 'calls update_paths on sub_folders' do
      sub_folders = create_list(:folder, 2, parent_folder: folder)
      folder.move_to(new_parent_folder)
      sub_folders.each(&:reload)
      updated_paths = sub_folders.map { |sub_folder| "#{new_parent_folder.path}/#{folder.name}/#{sub_folder.name}" }
      expect(sub_folders.map(&:path)).to eq(updated_paths)
    end
  end
end
