# frozen_string_literal: true

require "rails_helper"

RSpec.describe Directory, type: :model do
  describe "associations" do
    it do
      is_expected.to belong_to(:parent)
        .class_name("Directory")
        .counter_cache(:subdirectories_count)
        .inverse_of(:subdirectories)
        .optional(true)
    end

    it do
      is_expected.to have_many(:subdirectories)
        .class_name("Directory")
        .with_foreign_key(:parent_id)
        .inverse_of(:parent)
        .dependent(:destroy)
    end

    it { is_expected.to have_many_attached(:files) }
  end

  describe "validations" do
    subject(:directory) { build(:directory) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_most(255) }
    it { expect(directory).to validate_uniqueness_of(:name).scoped_to(:parent_id) }

    describe "#parent" do
      context "when associated with a valid parent" do
        subject { build(:directory, :as_subdirectory) }

        it { is_expected.to be_valid }
      end

      context "when directory is self referenced" do
        subject(:directory) { create(:directory) }

        before do
          directory.parent = directory
          directory.save
        end

        it { is_expected.to have_an_error_on(:parent_id).with_message(:self_referenced) }
      end

      context "when directory is associated with its subdirectories" do
        subject(:directory) { create(:directory, :with_subdirectories) }

        before do
          directory.parent = directory.subdirectories.first
          directory.save
        end

        it { is_expected.to have_an_error_on(:parent_id).with_message(:parent_is_a_subdirectory) }
      end
    end
  end

  describe "instance methods" do
    describe "#files" do
      context "when the directory has files" do
        subject(:directory) { build(:directory, :with_file) }

        it { expect(directory.files).to be_attached }
        it { expect(directory.files.count).to eq(1) }
      end

      context "when the directory has no files" do
        subject(:directory) { build(:directory, :with_subdirectories) }

        it { expect(directory.files).not_to be_attached }
        it { expect(directory.files.count).to eq(0) }
      end
    end
  end

  describe "database" do
    it { is_expected.to have_db_column(:parent_id).of_type(:integer).with_options(null: true) }

    it { is_expected.to have_db_column(:name).of_type(:string).with_options(limit: 255, null: false) }
    it { is_expected.to have_db_column(:subdirectories_count).of_type(:integer).with_options(null: false, default: 0) }

    it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }

    describe "checks" do
      context "when parent_id is equal to id" do
        subject(:directory) { create(:directory) }

        before { directory.parent = directory }

        it { is_expected.to violates_db_check_constraint("directories_parent_id_check") }
      end
    end

    describe "indexes" do
      it { is_expected.to have_db_index(%i[parent_id name]).unique(true) }
    end

    describe "foreign keys" do
      subject { build(:directory) }

      it { is_expected.to have_a_foreign_key_on(:parent_id).with_name(:directories_parent_id_fkey) }
    end

    describe "triggers" do
      context "when parent_id is a child of current directory" do
        # subject(:directory) { create(:directory, :with_subdirectories) }
        #
        # before { directory.parent = directory.subdirectories.first }
        #
        # it { is_expected.to violates_db_check_constraint("directories_parent_id_cyclic_reference_check") }
        pending "implement a trigger to check if necessary"
      end
    end
  end
end
