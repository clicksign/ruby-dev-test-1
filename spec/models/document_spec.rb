require 'rails_helper'

RSpec.describe Document, type: :model do
  it { should belong_to :directory }
  it { should have_one_attached :attached_content }
  it { should validate_presence_of :name }

  it 'is expected to validate that :content cannot be empty/false if :database storage_type' do
    document = build(:document, storage_type: :database)
    expect(document).to validate_presence_of(:content)
  end

  it 'is expected to validate that :content cannot be empty/false unless :database storage_type' do
    document = build(:document, storage_type: :s3)
    expect(document).to_not validate_presence_of(:content)
  end

  it do
    should define_enum_for(:storage_type).with_values(
      {
        database: 'database',
        disk: 'disk',
        s3: 's3'
      }
    ).backed_by_column_of_type(:string)
  end

  describe '#assign_content' do
    let(:file_path) { Rails.root.join('spec', 'fixtures', 'files', 'image.png').to_s }

    context 'with :s3 storage type' do
      subject { build(:document, storage_type: :s3) }

      before { subject.assign_content(file_path) }

      it { expect(subject.attached_content).to be_attached }
      it { expect(subject.content).to be_nil }
    end

    context 'with :disk storage type' do
      subject { build(:document, storage_type: :disk) }

      before { subject.assign_content(file_path) }

      it { expect(subject.attached_content).to be_attached }
      it { expect(subject.content).to be_nil }
    end

    context 'with :database storage type' do
      subject { build(:document, storage_type: :database) }

      before { subject.assign_content(file_path) }

      it { expect(subject.attached_content).to_not be_attached }
      it { expect(subject.content).to_not be_nil }
    end
  end

  describe '#attached_content' do
    subject { build(:document, :with_file).attached_content }

    it { is_expected.to be_a_instance_of(ActiveStorage::Attached::One) }

    context 'with :s3 storage type' do
      subject { build(:document, :with_file, storage_type: :s3).attached_content }

      it { is_expected.to be_attached }
    end

    context 'with :disk storage type' do
      subject { build(:document, :with_file, storage_type: :disk).attached_content }

      it { is_expected.to be_attached }
    end

    context 'with :database storage type' do
      subject { build(:document, :with_file, storage_type: :database).attached_content }

      it { is_expected.to_not be_attached }
    end
  end

  describe '#content' do
    context 'with :s3 storage type' do
      subject { build(:document, :with_file, storage_type: :s3).content }

      it { is_expected.to be_nil }
    end

    context 'with :disk storage type' do
      subject { build(:document, :with_file, storage_type: :disk).content }

      it { is_expected.to be_nil }
    end

    context 'with :database storage type' do
      subject { build(:document, :with_file, storage_type: :database).content }

      it { is_expected.to_not be_nil }
    end
  end
end
