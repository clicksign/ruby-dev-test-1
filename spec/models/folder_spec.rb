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
      it "test files children relation" do
        folder = FactoryBot.create(:folder)
        image_file = "image.png"
        pdf_file = "file.pdf"
        
        folder.files.attach(io: File.open("spec/files/#{image_file}"), filename: image_file)
        folder.files.attach(io: File.open("spec/files/#{pdf_file}"), filename: pdf_file)
        
        folder.save
        folder.reload

        expect(folder.files.count).to eq(2)
        expect(folder.files.first.blob.filename).to eq(image_file)
        expect(folder.files.last.blob.filename).to eq(pdf_file)
      end
    end
  end
  describe "Actions" do
    describe "with file" do
      it "rename" do
        folder = FactoryBot.create(:folder_with_children)
        
        folder.files.first.rename("new_name.pdf")
        folder.save
        folder.reload

        expect(folder.files.first.blob.filename).to eq("new_name.pdf")
      end
      it "delete" do
        folder = FactoryBot.create(:folder_with_children)
        
        folder.files.first.destroy!
        folder.save
        folder.reload

        expect(folder.files.count).to eq(1)
      end
      it "move" do
        folder = FactoryBot.create(:folder_with_children)
        folder2 = FactoryBot.create(:folder, name: "folder2")

        file_to_move = folder.files.first
        file_to_move.move(folder2)
        
        folder.save
        folder.reload
        folder2.reload

        expect(folder.files.count).to eq(1)
        expect(folder2.files.count).to eq(1)
        expect(folder2.files.first.blob.filename).to eq(file_to_move.blob.filename)
      end
      it "get path" do
        folder = FactoryBot.create(:folder_with_children)
        child_file = folder.files.first

        expect(child_file.path).to eq("#{folder.name}/#{child_file.blob.filename}")
      end
    end
    describe "with folder" do
      it "rename" do
        folder = FactoryBot.create(:folder_with_children)
        
        folder.folders.first.rename("new_name")
        folder.save
        folder.reload

        expect(folder.folders.first.name).to eq("new_name")
      end
      it "delete (should be cascade)" do
        folder = FactoryBot.create(:folder_with_children)
        child_folder = folder.folders.first

        child_folder.files.attach(io: File.open("spec/files/file.pdf"), filename: "file.pdf")
        
        child_folder.save
        child_folder.reload
        child_folder.destroy!

        expect(folder.folders.count).to eq(1)
        expect(ActiveStorage::Attachment.exists?(id=3)).to eq(false)
      end
      it "move" do
        folder = FactoryBot.create(:folder_with_children)
        folder2 = FactoryBot.create(:folder, name: "folder2")

        folder_to_move = folder.folders.first
        folder_to_move.move(folder2)
        
        folder.save
        folder.reload
        folder2.reload

        expect(folder.folders.count).to eq(1)
        expect(folder2.folders.count).to eq(1)
        expect(folder2.folders.first.name).to eq(folder_to_move.name)
        expect(folder_to_move.parent).to eq(folder2)
      end
      it "get path method" do
        folder = FactoryBot.create(:folder_with_children)
        child_folder = folder.folders.first

        expect(child_folder.path).to eq("#{folder.name}/#{child_folder.name}")
      end
      it "get children method" do
        folder = FactoryBot.create(:folder_with_children)
  
        expect(folder.children.count).to eq(4)
      end
    end
    
  end
end
