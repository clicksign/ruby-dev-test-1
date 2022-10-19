require 'rails_helper'

RSpec.describe Folder, type: :model do
  it { is_expected.to have_many(:documents) }
  # TODO: figure out how to test this optional parent status
  # it { is_expected.to belong_to(:parent) }
  it { is_expected.to have_many(:children) }

  let(:folder) { create(:folder) }
  let(:second_folder) { create(:folder) }

  describe 'Creation' do
    context 'same name rules' do
      subject { create(:folder) }
      it 'should create first model without issue' do
        expect { subject }.to change(Folder, :count).by 1
      end

      it 'should create first model without issue' do
        folder
        expect { second_folder }.to change(Folder, :count).by 1
        expect(second_folder.attributes).to include('name' => 'New Folder (1)')
      end
    end
  end
end
