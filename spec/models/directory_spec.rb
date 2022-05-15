require 'rails_helper'
include ActiveModel::Model

RSpec.describe Directory, type: :model do
  describe "Associations" do
    it { should belong_to(:parent).without_validating_presence }
    it { should have_many(:subdirectories).dependent(:destroy) }
  end

  describe "Validations" do
    it { should validate_presence_of(:title) }
  end

  it "has many files" do
    expect(subject.files).to be_an_instance_of(
                               ActiveStorage::Attached::Many
                             )
  end
end
