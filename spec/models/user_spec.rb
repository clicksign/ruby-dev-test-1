require 'rails_helper'

RSpec.describe User, type: :model do
  context "factories" do
    context "when valid" do
      subject { build :user }
      it { is_expected.to be_valid }
    end

    context "when invalid" do
      context "without password" do
        subject { build :user, password: nil }
        it { is_expected.to be_invalid }
      end

      context "without name" do
        subject { build :user, name: nil }
        it { is_expected.to be_invalid }
      end

      context "without email" do
        subject { build :user, email: nil }
        it { is_expected.to be_invalid }
      end
    end
  end

  context "validations" do
    subject { build :user }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end
end
