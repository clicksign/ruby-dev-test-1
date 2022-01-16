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
        expect(folder.save).to eq(true)
        expect(folder.name).to eq("folder1")
    end
  end
  describe "Relations" do
    context "with folders" do
      it "test folder parent relation" do
        folder = FactoryBot.create(:folder)
        parent = FactoryBot.create(:folder, name: "parent")
        
        folder.parent = parent
        folder.save

        expect(folder.parent).to eq(parent)
        expect(parent.children.first).to eq(folder)
      end
      it "test folder childrens relation" do
        folder = FactoryBot.create(:folder)
        child1 = FactoryBot.create(:folder, name: "child1")
        child2 = FactoryBot.create(:folder, name: "child2")
        
        folder.folders << child1
        folder.folders << child2
        folder.save

        expect(folder.folders.count).to eq(2)
        expect(folder.folders.first).to eq(child1)
        expect(folder.folders.last).to eq(child2)
      end
    end
    context "with assets" do
      it "test files relation"
      it "get files"
    end
  end
  describe "Actions" do
    describe "with file" do
      it "rename"
      it "delete"
    end
    describe "with folder" do
      it "rename"
      it "delete (should be cascade)"
    end
    it "get childrens with the all custom method"
end
