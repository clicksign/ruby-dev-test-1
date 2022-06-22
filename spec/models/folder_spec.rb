require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'ActiveRecord validations' do
    it { is_expected.to belong_to(:folder).optional }
    it { is_expected.to have_db_index('name, COALESCE(folder_id, (0)::bigint)').unique(true) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(64) }

    it do
      expect(described_class.new).to validate_numericality_of(:size)
        .only_integer.is_greater_than_or_equal_to(0)
    end
  end

  describe 'custom validations' do
    it 'add error cant_be_parent if when folder_id with his subfolders id' do
      parent_folder = create(:folder)
      subfolder = create(:folder, folder: parent_folder)
      parent_folder.update(folder: subfolder)

      expect(parent_folder.errors.details[:folder_id])
        .to include({ error: :cant_be_parent })
    end

    it 'add error cant_be_parent if when folder_id with his indirect subfolders id' do
      parent_folder = create(:folder)
      subfolder = create(:folder, folder: parent_folder)
      descendant = create(:folder, folder: subfolder)
      parent_folder.update(folder: descendant)

      expect(parent_folder.errors.details[:folder_id])
        .to include({ error: :cant_be_parent })
    end
  end

  describe 'before actions' do
    describe 'save' do
      it 'set empty path_ids if folder is null' do
        parent_folder = build(:folder)

        expect { parent_folder.save }.not_to change(parent_folder, :path_ids)
        expect(parent_folder.path_ids).to be_empty
      end

      it 'set correct path_ids to subfolder' do
        parent_folder = create(:folder, name: 'Folder 1')
        subfolder = create(:folder, folder: parent_folder, name: 'Folder 2')
        descendant = create(:folder, folder: subfolder, name: 'Folder 3')

        expect(parent_folder.path_ids).to be_empty
        expect(subfolder.path_ids).to eq([parent_folder.id])
        expect(descendant.path_ids).to eq([parent_folder.id, subfolder.id])
      end
    end
  end
end
