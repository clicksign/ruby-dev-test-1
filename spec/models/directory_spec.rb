require 'rails_helper'

RSpec.describe Directory, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:parent).optional(true) }
    it { is_expected.to have_many(:sub_directories).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:name).scoped_to(:parent_id) }
  end

  it 'has many files' do
    expect(subject.files).to be_an_instance_of(ActiveStorage::Attached::Many)
  end
end
