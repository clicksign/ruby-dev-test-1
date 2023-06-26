require 'rails_helper'

RSpec.describe Directory, type: :model do
  context "factories" do
    context "when hasn't parent" do
      subject { build :directory }
      it { is_expected.to be_valid }
    end

    context "when has parent" do
      subject { build :directory, :with_parent }
      it { is_expected.to be_valid }
    end
  end

  context "associations" do
    it { is_expected.to belong_to(:parent).class_name('Directory').optional  }
    it { is_expected.to have_many(:sub_dirs).class_name('Directory').with_foreign_key("parent_id").dependent(:destroy) }
    it { is_expected.to have_many(:archives).dependent(:destroy) }
  end

  context "validations" do
    subject { build :directory }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to([:parent_id, :user_id]) }
  end
end
