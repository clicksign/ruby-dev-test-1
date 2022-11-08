require "rails_helper"

RSpec.describe Directory, type: :model do
  subject { create(:directory) }

  it { expect(subject).to(be_valid) }

  describe "associations" do
    it { expect(subject).to(belong_to(:parent).class_name("Directory").optional(true)) }
    it { expect(subject).to(have_many(:subdirectories).class_name("Directory").dependent(:destroy)) }
    it { expect(subject).to(have_many(:documents).dependent(:destroy)) }
  end

  describe "validations" do
    it { expect(subject).to(validate_presence_of(:name)) }
    it { expect(subject).to(validate_uniqueness_of(:name).scoped_to(:parent_id)) }
  end

  describe "getters" do
    let(:file_size) { subject.documents.includes(:content_blob).sum(&:size) }
    let(:dir_name) { subject.name }

    context "#path" do
      it { expect(subject.path).to(eq("/#{dir_name}")) }
    end

    context "#size" do
      it { expect(subject.size).to(eq(file_size)) }
    end
  end

  describe "when directory has a parent" do
    subject(:subject_with_parent) { create(:directory, :with_parent) }
    let(:dir_name) { subject_with_parent.name }

    context "#path" do
      it { expect(subject_with_parent.path).to(eq("#{subject_with_parent.parent.path}/#{dir_name}")) }
    end
  end

  describe "when directory has subdirectories" do
    subject(:subject_with_subdirectories) { create(:directory, :with_subdirectories) }
    let(:folder_documents_size) { subject_with_subdirectories.documents.includes(:content_blob).sum(&:size) }

    context "#size" do
      it { expect(subject_with_subdirectories.size).to(be > folder_documents_size) }
    end
  end
end
