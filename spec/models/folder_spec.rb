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
        folder.reload

        expect(folder.parent).to eq(parent)
        expect(parent.folders.first).to eq(folder)
      end
      it "test folder children relation" do
        folder = FactoryBot.create(:folder)
        child1 = FactoryBot.create(:folder, name: "child1")
        child2 = FactoryBot.create(:folder, name: "child2")
        
        folder.folders << child1
        folder.folders << child2
        
        folder.save
        folder.reload

        expect(folder.folders.count).to eq(2)
        expect(folder.folders.first).to eq(child1)
        expect(folder.folders.last).to eq(child2)
      end
    end
    context "with files" do
      it "test files parent relation"
      it "test files children relation" do
        # folder = FactoryBot.create(:folder)
        # file2 = FactoryBot.create(:pdf_file, name: "file2")
        # file1 = FactoryBot.create(:image_file, name: "file1")
        
        # folder.files << file1
        # folder.files << file2
        
        # folder.save
        # folder.reload

        # expect(folder.files.count).to eq(2)
        # expect(folder.files.first).to eq(file1)
        # expect(folder.files.last).to eq(file2)
      end
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
end
