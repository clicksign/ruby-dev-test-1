require 'rails_helper'

RSpec.describe Archive, type: :model do
  it_behaves_like 'nameable' do
    subject { create(:archive) }
  end

  describe 'validations' do
    describe 'file needs to be attached' do
      subject { build(:archive, file: file) }

      context 'when file is attached' do
        let(:file) { fixture_file_upload('file.txt') }

        it { is_expected.to be_valid }
      end

      context 'when file is not attached' do
        let(:file) { nil }

        it { is_expected.not_to be_valid }
      end
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:parent) }
    it { is_expected.to have_one_attached(:file) }
  end

  describe 'callbacks' do
    describe 'update full path' do
      context 'when save new archive' do
        let(:directory) { create(:directory) }
        let(:archive) { build(:archive, parent: directory) }
        it do
          expect { archive.save }.to change(archive, :full_path)
                                       .from(nil)
                                       .to("#{directory.full_path}/"\
                                           "#{archive.name}")
        end
      end

      context 'when update name update full_path' do
        let(:old_name) { Faker::Fantasy::Tolkien.character }
        let(:new_name) { Faker::Fantasy::Tolkien.character }
        let(:directory) { create(:directory) }
        let(:archive) { create(:archive, name: old_name, parent: directory) }
        let(:update_name) { archive.update(name: new_name) }

        it do
          expect { update_name }.to change(archive, :full_path)
                                    .from("#{directory.full_path}/#{old_name}")
                                    .to("#{directory.full_path}/#{new_name}")
        end
      end
    end
  end
end
