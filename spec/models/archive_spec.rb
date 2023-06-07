require 'rails_helper'

RSpec.describe Archive, type: :model do
  describe 'associations' do
    it { should belong_to(:folder) }
  end

  describe 'validations' do
    context 'presence' do
      it { should validate_presence_of(:name) }
    end

    context 'factory' do
      it { expect(build(:archive)).to be_valid }
    end

    context 'unique index' do
      subject { create(:archive) }
      it { should validate_uniqueness_of(:name).scoped_to(:folder_id) }
    end

    it { should have_one_attached(:file) }
  end

  describe 'upload file' do
    before(:each) do
      @archive = FactoryBot.create(:archive)
      @archive.file.attach(io: File.open("./spec/fixtures/files/file_example.txt"), filename: 'file_example.txt')
      @archive.save!
    end

    it "has attached the file" do
      expect(@archive.file).to be_attached
    end
  end
end
