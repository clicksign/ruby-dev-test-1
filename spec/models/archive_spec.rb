require 'rails_helper'

RSpec.describe Archive, type: :model do
  describe 'validations' do
    subject { create(:archive) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(250) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:directory_id) }

    describe "name cannot start with '/' or ' '" do
      let(:directory) { build(:directory, name: name) }

      context 'when name is valid' do
        let(:name) { 'some valid name' }

        it { expect(directory).to be_valid }
      end

      context "when name starts with '/'" do
        let(:name) { '/invalid name' }

        it { expect(directory).not_to be_valid }
      end

      context "when name starts with ' '" do
        let(:name) { ' invalid name' }

        it { expect(directory).not_to be_valid }
      end
    end

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
    it { is_expected.to belong_to(:directory) }
    it { is_expected.to have_one_attached(:file) }
  end

  describe 'callbacks' do
    describe 'update full path' do
      context 'when parent is empty' do
        let(:directory) { build(:directory, parent: nil) }
        it do
          expect { directory.save }.to change(directory, :full_path)
                                       .from(nil).to("/#{directory.name}")
        end
      end

      context 'when have parent' do
        let(:parent) { create(:directory) }
        let(:directory) { build(:directory, parent: parent) }

        it do
          expect { directory.save }.to change(directory, :full_path)
                                       .from(nil).to("#{parent.full_path}/"\
                                        "#{directory.name}")
        end
      end

      context 'when update name update full_path' do
        let(:old_name) { Faker::Fantasy::Tolkien.character }
        let(:new_name) { Faker::Fantasy::Tolkien.character }
        let(:directory) { create(:directory, name: old_name, parent: nil) }
        let(:update_name) { directory.update(name: new_name) }

        it do
          expect { update_name }.to change(directory, :full_path)
                                    .from("/#{old_name}")
                                    .to("/#{new_name}")
        end
      end
    end
  end
end
