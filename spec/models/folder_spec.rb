require 'rails_helper'

RSpec.describe Folder, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).scoped_to(:ref_id) }
  end

  describe 'associations' do
    it do
      should have_many(:subfolders)
        .class_name('Folder')
        .with_foreign_key('ref_id')
        .dependent(:delete_all)
    end

    it { should belong_to(:ref).optional.class_name('Folder') }
    it { should have_many(:subfolders) }
  end
end
