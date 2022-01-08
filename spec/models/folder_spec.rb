require 'rails_helper'

RSpec.describe Folder, type: :model do

  subject { FactoryBot.create(:folder) }
  # happy path
  it "should be possible to create valid params" do
    expect(subject).to be_valid
  end
  # sad path
  it "should not be possible to create without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it "should be possible to create a folder within other" do
    folder = FactoryBot.create(:folder)
    folder.parent_folder_id = subject.id
    folder.save!
    expect(folder.parent_folder).to eq(subject)
  end

  it { should have_many(:subfolders) }
  it { should belong_to(:parent_folder).optional(true) }

end