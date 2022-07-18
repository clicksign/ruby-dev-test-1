require 'rails_helper'

RSpec.describe FileSystem, type: :model do
  

  describe '.create' do

    dir = Directory.create(name: "folder")
    sub_dir = Directory.create(name: "sub_folder", parent: dir)
    file = LocalFile.create(name: "file.ext", parent: sub_dir)
    
    context "When missing required fields" do
       it { should validate_presence_of(:name) }
    end

    context "When is Directory" do
      it "type will be Directory" do
        expect(dir.type).to be == "Directory"
      end
    end

    context "When is File" do
      it "type will be LocalFile" do
        expect(file.type).to be == "LocalFile"
      end
      
      it "need have a parent" do
        expect(file.parent).to be_truthy
      end
    end

  end

  describe '#path' do
    context "When is Directory" do
      let(:dir) { FactoryBot.create(:root_directory) }
      it("check pattern") do 
        expect(dir.path).to be == "/folder"
      end
    end
    
    context "When is File" do
      let(:file) { FactoryBot.create(:local_file) }
      it("check pattern") do 
        expect(file.path).to be == "/folder/sub_folder/file.ext"
      end
    end
  end
end
