require 'rails_helper'

describe FileResource do
  let! (:folder) { Folder.create!(name: 'Folder 01') }
  let! (:file_resource) { FileResource.create(name: 'File 01', folder: folder) }
  let! (:invalid_name_file) { FileResource.new(name: nil, folder: folder) }
  let! (:invalid_folder_file) { FileResource.new(name: 'File 02') }

  describe "validations" do
    it "is invalid without name" do
      invalid_name_file.valid?
      expect(invalid_name_file.errors[:name]).to include("can't be blank")
    end

    it "is invalid without folder" do
      invalid_folder_file.valid?
      expect(invalid_folder_file.errors[:folder]).to include("can't be blank")
    end

    it "is valid with name and folder" do
      expect(file_resource).to be_valid
    end

    it "is invalid with duplicate name and folder" do
      dup = file_resource.dup
      expect(dup).to be_invalid
    end

    it "is valid with duplicate name and different folder" do
      dup = file_resource.dup
      dup.folder = Folder.create(name: 'Folder 02')
      expect(dup).to be_valid
    end

    it "is valid with lowecase name" do
      dup = file_resource.dup
      dup.name = 'file 01'
      expect(file_resource).to be_valid
    end
  end

  describe "relationships" do
    it "has folder" do
      expect(file_resource.folder).to eq(folder)
    end
  end

  describe "methods" do
    it "show breadcrumbs" do
      expect(folder.breadcrumbs).to eq('Folder 01')
      expect(file_resource.breadcrumbs).to eq('Folder 01/File 01')
    end
  end
end
