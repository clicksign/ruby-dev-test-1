require 'rails_helper'

RSpec.describe Directory, type: :model do
  let!(:directory) { create(:directory) }

  context 'validation directory' do
    it { should have_many(:subdirectories).dependent(:destroy) }
    it { should have_many(:archives).dependent(:destroy) }
    it { should belong_to(:parent).optional(true) }
    it { should validate_presence_of(:dirname) }
    it { should validate_uniqueness_of(:dirname).scoped_to(:parent_id) }
  end

  context 'when you have directory' do
    context 'subdirectories dirname cannot be the same' do
      let(:directory1) { build(:directory, dirname: directory.dirname) }

      it 'return error' do
        expect(directory1).to be_invalid
      end
    end

    context "dirname should present" do
      let(:directory) { build(:directory, dirname: nil) }
      it 'return error' do
        expect(directory).to be_invalid
      end
    end

    context "when you have directory and you want to delete and the subdirectories" do
      it 'return sucess' do
        expect(directory.subdirectories.count).to eq(0)
        expect { directory.destroy }.to change { Directory.count }.by(-1)
        expect { directory.reload }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
