require 'rails_helper'

RSpec.describe Directory, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:parent).class_name('Directory').optional }
    it { is_expected.to have_many(:subdirectories).class_name('Directory').with_foreign_key(:parent_id).inverse_of(:parent) }
  end

  describe 'validations' do
    subject { build(:directory) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to be_valid }
  end

  describe '#files' do
    subject { create(:directory, :with_attachment).files }

    it { is_expected.to be_an_instance_of(ActiveStorage::Attached::Many) }
    it { expect(subject).to be_attached }
  end

  describe 'create directory' do
    context 'with subdirectories' do
      let(:subdirectories_quantity) { rand(1..5) }
      let!(:directory) { create(:directory, :with_multiple_subdirectory, quantity: subdirectories_quantity) }

      it { expect(directory.subdirectories.count).to eq(subdirectories_quantity) }

      context 'with multiple level subdirectories' do
        let!(:parent) { create(:directory) }
        let!(:child1) { create(:directory, parent: parent) }
        let!(:child2) { create(:directory, parent: child1) }
        let!(:child3) { create(:directory, parent: child2) }

        it 'validate sub levels' do
          expect(parent.subdirectories).to include(child1)
          expect(child1.subdirectories).to include(child2)
          expect(child2.subdirectories).to include(child3)
        end
      end
    end

    %w[image.jpg document.pdf csv-sample.csv].each do |file_name|
      let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', file_name) }
      let(:file) { File.open(file_path) }

      context 'with local file' do
        subject { build(:directory) }

        before do
          subject.files.attach(io: file, filename: File.basename(file))
        end

        it { is_expected.to be_valid }
        it { expect(subject.files).to be_attached }
      end

      context 'with blob' do
        subject { build(:directory, files: [attachment_file]) }

        let(:attachment_file) { ActiveStorage::Blob.create_and_upload!(io: File.open(file_path), filename: file_name) }

        it { is_expected.to be_valid }
        it { expect(subject.files).to be_attached }
      end

      context 'with signed id' do
        subject { build(:directory, files: [attachment_file]) }

        let(:attachment_file) { ActiveStorage::Blob.create_and_upload!(io: File.open(file), filename: file_name) }

        it { is_expected.to be_valid }
        it { expect(subject.files).to be_attached }
      end
    end
  end
end
