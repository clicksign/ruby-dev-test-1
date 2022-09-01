RSpec.describe FileDirectory, type: :model do
  describe "attachments" do
    context "when files is present" do
      let(:file_directory) { build(:file_directory, :with_files) }

      it { expect(file_directory.files).to be_attached }
    end
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:path) }
    specify do
      create(:file_directory)
      is_expected.to validate_uniqueness_of(:path).scoped_to(:root_file_directory_id, :main_file_directory_id)
                                                  .ignoring_case_sensitivity
    end
  end

  describe "associations" do
    it { is_expected.to belong_to(:root_file_directory).class_name("FileDirectory").optional(true) }
    it { is_expected.to belong_to(:main_file_directory).class_name("FileDirectory").optional(true) }
  end
end
