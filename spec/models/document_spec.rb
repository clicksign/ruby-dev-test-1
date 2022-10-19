require 'rails_helper'

RSpec.describe Document, type: :model do
  it { is_expected.to belong_to(:folder) }
  it { is_expected.to have_one_attached(:file) }

  let(:document) { create(:document) }
  let(:second_document) { create(:document) }

  describe 'Creation' do
    context 'same name rules' do
      subject { create(:document) }
      it 'should create first model without issue' do
        expect { subject }.to change(Document, :count).by 1
      end

      it 'should create first model without issue' do
        document
        expect { second_document.save }.to change(Document, :count).by 1
        expect(second_document.attributes).to include('name' => 'New Document (1)')
      end
    end
  end
end
