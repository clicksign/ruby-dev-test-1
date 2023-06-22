require 'rails_helper'

RSpec.describe Directory, type: :model do
  it 'validates the presence of the name' do
    directory = Directory.new
    expect(directory.valid?).to be_falsey
    expect(directory.errors[:name]).to include("can't be blank")
  end

  it 'validates associations' do
    directory = Directory.new(name: 'Test Directory')
    subdirectory = Directory.new(name: 'Subdirectory')

    directory.subdirectories << subdirectory

    expect(directory.subdirectories).to include(subdirectory)
    expect(subdirectory.parent).to eq(directory)
  end

  it 'attaches a file' do
    directory = Directory.new(name: 'Test Directory')
    file = fixture_file_upload(Rails.root.join('spec', 'fixtures', 'test_file.txt'))

    directory.attach_file(file)

    expect(directory.files).to be_attached
  end
end
