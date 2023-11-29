require 'rails_helper'

RSpec.describe Document, type: :model do
  context 'associations' do
    it { should belong_to(:folder) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:file) }

    let(:document) { FactoryBot.create(:document) }
    let(:invalid_document) { FactoryBot.build(:document, name: nil) }
  
    it 'when document is valid' do
      expect(document).to be_valid
      expect(document.file.attached?).to be true  
    end
  
    it 'when document not valid because a missing name' do
      expect(invalid_document.valid?).to be(false)
      expect(invalid_document.errors.full_messages).to eq(["Name can't be blank"])
    end
  end
end
