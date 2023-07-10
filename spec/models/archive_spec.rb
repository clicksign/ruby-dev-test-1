# == Schema Information
#
# Table name: archives
#
#  id         :uuid             not null, primary key
#  file       :string           not null
#  status     :integer          default("active"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  folder_id  :uuid             not null
#
# Indexes
#
#  index_archives_on_folder_id  (folder_id)
#
# Foreign Keys
#
#  fk_rails_...  (folder_id => folders.id)
#
require 'rails_helper'

RSpec.describe Archive, type: :model do
  describe 'validations' do
    subject(:archive) { build(:archive) }

    context 'presence_of' do
      it_behaves_like 'when not has value in attribute', 'status'
      it_behaves_like 'when not has value in attribute', 'file'
      it_behaves_like 'when not has value in attribute', 'folder'
    end

    context 'status' do
      context 'when has invalid value' do
        subject(:archive_invalid) { build(:archive, status: 'invalid') }

        it { expect { archive_invalid }.to raise_error(ArgumentError) }
      end
    end
  end

  describe 'when has file' do
    context 'when has valid value' do
      subject(:file) { archive.file }

      let(:archive) { create(:archive) }

      it { expect(archive).to be_valid }
      it { expect(file.identifier).to eq('example.png') }
    end
  end
end
