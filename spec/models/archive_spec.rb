require 'rails_helper'

RSpec.describe Archive, type: :model do
  subject(:archive) { FactoryBot.create(:archive) }

  describe 'When associations are valid' do
    it { is_expected.to belong_to(:directory)}
  end

  describe 'When validations are present in model' do
    it { should validate_presence_of(:name) }

    it 'should be blank' do
      expect{FactoryBot.create(:archive, name: '')}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
end