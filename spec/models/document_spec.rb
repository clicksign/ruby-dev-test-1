require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'relationship' do
    it { is_expected.to belong_to(:folder) }
  end

  context 'validates' do
    it { expect { create(:document_with_folder) }.to change { Document.all.size }.by(1) }
    it { is_expected.to have_one_attached(:file) }
    it { is_expected.to validate_presence_of(:title) }
  end

  context 'raise error' do
    it 'file no added' do
      expect { create(:document_without_file) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: File no added')
    end

    it "title can't be blank" do
      expect { create(:document_without_title) }.to raise_error(ActiveRecord::RecordInvalid, "Validation failed: Title can't be blank")
    end

    it 'folder must exist' do
      expect { create(:document_without_folder) }.to raise_error(ActiveRecord::RecordInvalid, 'Validation failed: Folder must exist')
    end
  end

  context 'instance methods' do
    describe '#check_file_presence' do
      context 'without file' do
        it 'returns error message' do
          document = build(:document, folder: build(:folder), file: nil)

          expect(document.check_file_presence).to eq(['no added'])
        end
      end

      context 'with file' do
        it 'returns nil' do
          document = build(:document, folder: build(:folder))

          expect(document.check_file_presence).to eq(nil)
        end
      end
    end
  end
end
