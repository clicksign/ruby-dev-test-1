require 'rails_helper'

RSpec.describe Archive, type: :model do
  context "factories" do
    context "when hasn't directory" do
      subject { build :archive, directory: nil }
      it { is_expected.to be_invalid }
    end

    context "when has directory" do
      subject { build :archive }
      it { is_expected.to be_valid }
    end

    context "when a valid file" do
      let(:archive) { create :archive, :with_doc_attach }

      it { expect(archive.file).to be_attached }

      it "to be an instance of attached" do
        expect(archive.file).to be_an_instance_of(ActiveStorage::Attached::One)
      end
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:directory) }
  end

  context "validations" do
    subject { build :archive }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:file) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to([:directory_id, :user_id]) }
  end

  context "attachments" do
    it { is_expected.to have_one_attached(:file) }
  end
end
