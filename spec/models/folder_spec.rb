require "rails_helper"

RSpec.describe Folder, type: :model do
  describe "object creation" do
    it "Invalid creation -> name should not be empty" do
        folder = FactoryBot.build(:folder, name: "")
        expect(folder.valid?).to eq(false)
    end
    it "Valid creation" do
        folder = FactoryBot.build(:folder)
        expect(folder.valid?).to eq(true)
    end
  end
  descrbie "Relations" do
    context "with folders" do
      it "test folder parent relation"
      it "test folder childrens relation"
      it "get parent"
    end
    context "with assets" do
      it "test asset relation"
      it "get assets"
    end
    context "with both" do
      it "get childrens"
      it "delete folder should be cascade"
    end
  end
end
