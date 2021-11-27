require 'rails_helper'

RSpec.describe Folder, type: :model do

  subject { FactoryBot.create(:folder) }

  it "should be valid with valid params" do
    expect(subject).to be_valid
  end

  it "should not be valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "should be valid to create a folder within another" do
    new_folder = FactoryBot.create(:folder)
    new_folder.parent_folder_id = subject.id
    new_folder.save!
    expect(new_folder.parent_folder).to eq(subject)
  end

  it { should have_many(:subfolders) }
  it { should belong_to(:parent_folder).optional(true) }
  
end
