require 'rails_helper'
describe Folder do
  let!(:invalid_folder) { Folder.new(name: nil) }
  let!(:folder) { Folder.create!(name: 'Folder 01') }
  let!(:subfolder) { Folder.create!(name: 'Subfolder 01', parent: folder) }

  describe "validations" do
    it "is invalid without name" do
      folder = Folder.new(name: nil)
      folder.valid?
      expect(folder.errors[:name]).to include("can't be blank")
    end

    it "is valid" do
      expect(folder.name).to eq('Folder 01')
    end
  end

  describe "relationships" do
    it "has subfolders" do
      expect(folder.subfolders.count).to eq(1)
    end

    it "has parent" do
      expect(subfolder.parent).to eq(folder)
    end
  end

  describe "methods" do
    it "show breadcrumbs" do
      expect(folder.breadcrumbs).to eq('Folder 01')
      expect(subfolder.breadcrumbs).to eq('Folder 01/Subfolder 01')
    end

    it "show tree data" do
      expect(folder.tree_data).to eq({
        name: 'Folder 01',
        subfolders: [
          {
            name: 'Subfolder 01',
            subfolders: [],
            files: []
          }
        ],
        files: []
      })

      expect(subfolder.tree_data).to eq({
        name: 'Subfolder 01',
        subfolders: [],
        files: []
      })
    end
  end

  describe "file association" do
    let!(:file) { FileResource.create!(name: 'File 01', folder: subfolder) }
    it "show tree data with files" do
      expect(folder.tree_data).to eq({
        name: 'Folder 01',
        subfolders: [
          {
            name: 'Subfolder 01',
            subfolders: [],
            files: [
              { name: 'File 01', path: file.path }
            ]
          }
        ],
        files: []
      })
    end
  end
end
