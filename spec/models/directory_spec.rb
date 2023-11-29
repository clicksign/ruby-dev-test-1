require 'rails_helper'

RSpec.describe Directory, type: :model do
  it { should belong_to(:parent_directory).optional }
  it { should have_many(:documents).dependent(:destroy) }

  it do
    should have_many(:subdirectories).class_name('Directory')
                                     .with_foreign_key('parent_directory_id')
                                     .dependent(:destroy)
  end

  it { should validate_presence_of :name }

  describe '#full_path' do
    let(:grand_parent_directory) { create(:directory, name: 'grand_parent') }
    let(:parent_directory) { create(:directory, name: 'parent', parent_directory: grand_parent_directory) }

    subject { create(:directory, name: 'directory', parent_directory: parent_directory).full_path }

    it 'is expected to return a full path of directory' do
      is_expected.to eq 'grand_parent/parent/directory'
    end
  end
end
