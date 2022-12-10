require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe "associations" do
    it { is_expected.to have_many_attached(:documents) }
    it { is_expected.to belong_to(:parent).class_name("Folder").optional }
    it { is_expected.to have_many(:children).class_name("Folder").with_foreign_key("parent_id").dependent(:destroy) }
  end

  describe "validations" do
    it "When name is present" do
      folder = build(:folder)
      expect(folder).to be_valid
    end

    it "When name is not present" do
      folder = build(:folder, name: nil)
      expect(folder).not_to be_valid
    end

    it "When parent is present" do
      folder = build(:folder, parent: create(:folder))
      expect(folder).to be_valid
    end

    it "When parent is not present" do
      folder = build(:folder, parent: nil)
      expect(folder).to be_valid
    end
  end
end
