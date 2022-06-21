require 'rails_helper'

describe FileResource do
  let! (:folder) { Folder.create!(name: 'Folder 01') }
  let! (:file_resource) { FileResource.new(name: 'File 01', folder: folder) }
  let! (:invalid_file_resource) { FileResource.new(name: nil) }

  describe "validations" do
    it "is invalid without name" do
      invalid_file_resource.valid?
      expect(invalid_file_resource.errors[:name]).to include("can't be blank")
    end

    it "is valid" do
      expect(file_resource.name).to eq('File 01')
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
