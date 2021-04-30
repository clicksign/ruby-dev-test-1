require 'rails_helper'

RSpec.describe Folder, type: :model do
  it "is not valid without any attributes" do
    folder = Folder.new
    expect(folder).to_not be_valid
  end

  it "is valid with all attributes" do
    folder = Folder.new(name: 'Folder1', created_at: DateTime.now, updated_at: DateTime.now)
    expect(folder).to be_valid
  end

  it "is valid with subfolders" do
    mainfolder = Folder.new(name: 'MainFolder', created_at: DateTime.now, updated_at: DateTime.now)
    mainfolder.save
    
    subfolder = Folder.new(name: 'SubFolder', main_folder_id: mainfolder.id, created_at: DateTime.now, updated_at: DateTime.now)

    expect(subfolder).to be_valid
    expect(subfolder.main_folder_id).to eq(mainfolder.id)
  end
end
