require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'associations' do
    it { should belong_to(:parent).optional }
    it { should have_many(:subfolders) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'valid factory' do
    it { expect(build(:folder)).to be_valid }
  end
end
