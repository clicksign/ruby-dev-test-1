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

        it 'should purge attached files and children files' do
          expect { subject }.to change { Folder.count }.from(5).to(0)
                                                       .and(change { ActiveStorage::Attachment.count }.from(3).to(0))
        end
      end
    end
  end
end
