require 'rails_helper'

RSpec.describe Directory, :type => :model do
  it "is a standard Directory" do
    directory = Directory.new(name:'Documents', path: 'home/', size:0)

    expect(Directory.new()).to be_valid
  end

  it "a subdirectory inside a directory" do
    directory = Directory.new(name:'Documents', path: 'home/', size:0)
    sub_directory = Directory.new(name:'Videos', path: 'home/Documents/', size:0)
    directory.sub_directories.append(sub_directory)
    directory.save()

    expect(Directory.where(name:'Documents').take.sub_directories[0]).to eq(sub_directory)
    expect(Directory.where(name:'Videos').take.parent_directory).to eq(directory)
  end
end

