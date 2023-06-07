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
  end
end
