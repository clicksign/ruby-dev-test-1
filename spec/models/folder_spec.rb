require 'rails_helper'

RSpec.describe Folder, type: :model do
  let(:user) { create(:user) }

  let(:root_folder) { create(:folder, user: user, name: 'Root', parent: nil) }
  let(:folder2) { create(:folder, user: user, name: 'Folder 1', parent: root_folder) }
  let(:folder3) { create(:folder, user: user, name: 'Folder 2', parent: folder2) }
  let(:folder4) { create(:folder, user: user, name: 'Folder 3', parent: folder3) }

  context 'relationship' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:documents) }
    it { is_expected.to have_many(:children) }
    it { is_expected.to belong_to(:parent).optional }
  end

  context 'validates' do
    it { expect { create(:folder_with_user) }.to change { Folder.all.size }.by(2) }
    it { is_expected.to validate_presence_of(:name) }
  end

  context 'raise error' do
    it 'user must exist' do
      expect { create(:folder_without_user) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: User must exist')
    end

    it "name can't be blank" do
      expect { create(:folder_without_name) }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Name can't be blank")
    end
  end

  context 'class methods' do
    describe '#network_parents' do
      it 'returns expected network parents 4 levels' do
        network = Folder.network_parents(folder4)
        expect(network[0].attributes['parent_id']).to eq(nil)
        expect(network[1].attributes['parent_id']).to eq(root_folder.id)
        expect(network[2].attributes['parent_id']).to eq(folder2.id)
        expect(network[3].attributes['parent_id']).to eq(folder3.id)
      end
    end
  end
end
