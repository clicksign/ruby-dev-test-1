require 'rails_helper'

RSpec.describe Folder, type: :model do
  it "is valid with valid attributes" do    
    expect(Folder.new(name: Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3))).to be_valid
  end

  it "is not valid without a name" do
    folder = Folder.new()
    expect(folder).to_not be_valid
  end

  it "is not valid with a existing name on same folder" do
    folder_name = Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3)
    folder_1 = Folder.create(name: folder_name)
    folder_2 = Folder.new(name: folder_name)
    expect(folder_2).to_not be_valid
  end

  it "is change the folder name" do
    folder_name = Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3)
    folder = Folder.last
    folder.update(name: folder_name)
    expect(folder.name).to eq(folder_name)
  end

  it "is has to have sub folders" do
    folder_name = Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3)    
    folder = Folder.create(name: folder_name)
    3.times do |i|
      folder.sub_folders.create(name: Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3))
    end   
    expect(folder.sub_folders.count > 0).to eq(true)
  end

  it "is do delete all sub folders" do
    folder = Folder.includes(:sub_folders).where.not(sub_folders: {id: nil}).first        
    folder.sub_folders.destroy_all
    expect(folder.sub_folders.count).to eq(0)
  end  

  it "is do delete all folders" do
    Folder.destroy_all    
    expect(Folder.count).to eq(0)
  end  
end
