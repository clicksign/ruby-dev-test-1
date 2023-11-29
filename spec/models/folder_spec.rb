require 'rails_helper'

RSpec.describe Folder, type: :model do
  context 'associations' do
    it { should belong_to(:parent).class_name('Folder').optional }
    it { should have_many(:child_folders).class_name('Folder').dependent(:destroy)  }
    it { should have_many(:documents).dependent(:destroy) }
  end

  context 'validations' do
    it { should validate_presence_of(:name) }
    
    let(:root_folder) { FactoryBot.create(:folder) }
    let(:child_folder) { FactoryBot.create(:folder, parent_id: root_folder.id) }
    let(:invalid_folder) { FactoryBot.build(:folder, name: nil) }

    it 'when folder is valid' do
      expect(root_folder).to be_valid
    end

    it 'when folder not valid because a missing name', :aggregate_failures do
      expect(invalid_folder.valid?).to be(false)
      expect(invalid_folder.errors.full_messages).to eq(["Name can't be blank"])
    end

    context 'delete child_folders when parent folder is deleted' do
      before do
        child_folder
        root_folder.destroy 
      end

      it do
        expect(Folder.all).to eq([])      
      end
    end
  end
end
