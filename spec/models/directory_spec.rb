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
end
