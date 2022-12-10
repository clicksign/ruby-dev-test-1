require 'rails_helper'

RSpec.describe Archive, type: :model do
  context 'validation archive' do

    it { should belong_to(:directory) }
    it { should validate_presence_of(:document) }

    context "when you have archive with a document" do
      subject { create(:archive, :with_document).document }
      it { is_expected.to be_an_instance_of(ActiveStorage::Attached::One) }
    end
  end


  context "when you have archive" do
    let(:archive) { build(:archive, document: nil) }

    context "without a document" do
      it "return not valid" do
        expect(archive).to be_invalid
      end
    end

    context "with a document" do
      let(:archive) { build(:archive, :with_document) }

      it "return valid" do
        expect(archive).to be_valid
      end
    end
  end

  context "when you have archive with document" do

    context "without a directory" do
      let(:archive) { build(:archive, :with_document, directory_id: nil) }

      it "return invalid" do
        expect(archive).to be_invalid
      end
    end

    context "with a directory" do
      let(:archive) { build(:archive, :with_document) }

      it "return valid" do
        expect(archive).to be_valid
      end
    end
  end
end
