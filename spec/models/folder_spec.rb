# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'validations' do
    subject { build :folder }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:parent_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:parent).optional }
    it { is_expected.to have_many(:children) }
  end

  describe '#from_root' do
    let!(:no_parent_folders) { create_list :folder, 3, parent: nil }

    before { create_list :folder, 5, parent: no_parent_folders.first }

    it 'should return only folders that have no parent directory' do
      expect(described_class.from_root).to eq(no_parent_folders)
    end
  end

  describe '.is_empty?' do
    let(:folder) { create :folder }

    subject { folder.is_empty? }

    context 'when there are no files or children directory associated' do
      it { is_expected.to be_truthy }
    end

    context 'when folder has files attached' do
      let(:folder) { create :folder, :with_file_attached }

      it { is_expected.to be_falsey }
    end

    context 'when folder has children directory associated' do
      before { create_list :folder, 2, parent: folder }

      it { is_expected.to be_falsey }
    end

    context 'when it have files and children directory attached' do
      let(:folder) { create :folder, :with_file_attached }

      before { create_list :folder, 2, parent: folder }

      it { is_expected.to be_falsey }
    end
  end

  describe '.path' do
    let(:folder) { create :folder }

    subject { folder.path }

    context 'when folder has no parent' do
      it { is_expected.to eq("/#{folder.name}") }
    end

    context 'when folder have parent' do
      let(:parent) { create :folder }
      let(:folder) { create :folder, parent: parent }

      it { is_expected.to eq("#{parent.path}/#{folder.name}") }
    end
  end

  describe '.destroy' do
    let(:folder) { create :folder }

    subject { folder.destroy }

    context 'when there are subfolders related' do
      before { create_list(:folder, 2, parent: folder) }

      it 'should delete children folders' do
        expect { subject }.to change { Folder.count }.from(3).to(0)
      end

      context 'when there are files attached' do
        let(:folder) { create :folder, :with_file_attached }

        it 'should purge attached files' do
          expect { subject }.to change { ActiveStorage::Attachment.count }.from(1).to(0)
        end
      end

      context 'when there are files attached to the subfolders' do
        let!(:folder) { create :folder, :with_file_attached }

        before { create_list(:folder, 2, :with_file_attached, parent: folder) }

        it "should purge attached files and children's attached files" do
          expect { subject }.to change { Folder.count }.from(5).to(0)
                                                       .and(change { ActiveStorage::Attachment.count }.from(3).to(0))
        end
      end
    end

    context 'when there are not subfolders related' do
      let!(:folder) { create :folder, :with_file_attached }

      it 'should purge attached files' do
        expect { subject }.to change { Folder.count }.from(1).to(0)
                                                     .and(change { ActiveStorage::Attachment.count }.from(1).to(0))
      end
    end
  end
end
