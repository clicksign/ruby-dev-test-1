require 'rails_helper'

RSpec.describe Upload, type: :model do
  it 'is valid with valid attributes' do 
    folder_name = Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3)
    folder = Folder.create(name: folder_name)
    upload = folder.uploads.new
    upload.file.attach(io: File.open(Rails.root.join('spec', 'factories', 'files', 'test.txt')), filename: 'test.txt', content_type: 'text/plain')
    expect(upload).to be_valid
  end  

  it 'is has to have at least one file' do
    folder_name = Faker::Alphanumeric.alphanumeric(number: 10, min_alpha: 3)    
    folder = Folder.create(name: folder_name)      
    upload = folder.uploads.new
    upload.file.attach(io: File.open(Rails.root.join('spec', 'factories', 'files', 'test.txt')), filename: 'test.txt', content_type: 'text/plain')
    upload.save
    expect(upload.file.attached?).to eq(true) 
  end

  it 'is not valid with duplicated name attributes' do     
    folder = Folder.last
    upload = folder.uploads.new
    upload.file.attach(io: File.open(Rails.root.join('spec', 'factories', 'files', 'test.txt')), filename: 'test.txt', content_type: 'text/plain')
    upload.save
    expect(upload).to_not be_valid
  end

  it 'is has to update the upload file' do    
    folder = Folder.last
    upload = folder.uploads.last
    upload.file.attach(io: File.open(Rails.root.join('spec', 'factories', 'files', 'test1.txt')), filename: 'test1.txt', content_type: 'text/plain')
    upload.save    
    expect(upload.file.attached?).to eq(true) 
  end
end
