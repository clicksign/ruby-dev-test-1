require 'rails_helper'

RSpec.describe Archive, type: :model do
  let(:archive) { build(:archive) }
  
  context 'uniqness' do
    it { expect(archive).to validate_uniqueness_of(:name).scoped_to(:folder_id) }
  end

  context 'associations' do
    it { should belong_to(:folder) }
  end

  context 'validations' do 
    it { expect(archive).to validate_presence_of(:name) }
    it { expect(archive).to validate_presence_of(:file) }
  end
end
