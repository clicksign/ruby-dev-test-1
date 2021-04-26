require 'rails_helper'

RSpec.describe Directory, type: :model do
  subject(:directory) { FactoryBot.create(:directory) }

  describe 'When associations are valid' do
    it { is_expected.to belong_to(:directory)}
    it { is_expected.to have_many(:directories)}
  end

  describe 'When validations are present in model' do
    it { should validate_presence_of(:name) }

    it 'should be blank' do
      expect{FactoryBot.create(:directory, name: '')}.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe '#clean_subdirectories' do
    context 'when the main directory has subdirectories' do
      let(:subdirectory) { FactoryBot.create(:directory, directory_id: subject.id) }

      before { [subject, subdirectory, subject.reload] }

      it 'should have subdirectories' do
        expect(subject.directories.count).to eq 1
      end

      it 'should be deleted all subdirectories' do
        subject.send(:clean_subdirectories)
        expect(subject.directories.count).to eq 0
      end
    end
  end
end