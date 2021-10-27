require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'relations' do
    it { should belong_to(:parent).optional }
    it { should have_many(:folders) }
  end

  describe 'attachments' do
    it 'should have many archives' do
      expect(subject.archives).to be_an_instance_of(
        ActiveStorage::Attached::Many)
    end
  end
end
