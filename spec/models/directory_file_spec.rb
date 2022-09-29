require 'rails_helper'

RSpec.describe DirectoryFile, :type => :model do
  it "is a standard file" do
    directory = Directory.new(name:'Documents', path: 'home/', size:0)
    expect(DirectoryFile.new(name:'Foto aleatoria', path: 'home/Documents', size:0, directory:directory)).to be_valid
  end

  it "is a standard file associated properly with a directory" do
    directory = Directory.new(name:'Documents', path: 'home/', size:0)
    file = DirectoryFile.new(name:'Foto aleatoria', path: 'home/Documents', size:0, directory:directory)
    file.save()

    expect(file.directory).to eq(directory)
    expect(directory.directory_files[0]).to eq(file)
  end

  it "is a standard file with a local file attached" do
    directory = Directory.new(name:'Documents', path: 'home/', size:0)
    file = DirectoryFile.new(name:'Foto aleatoria', path: 'home/Documents', size:0, directory:directory)
    file.file_content.attach(io: File.open(Rails.root.join('public', 'apple-touch-icon-precomposed.png')), filename: 'apple-touch-icon-precomposed.png', content_type: 'application/png')
    file.save()

    expect(file.file_content.attached?).to be_truthy
  end
end

