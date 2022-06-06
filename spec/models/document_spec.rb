require 'rails_helper'

RSpec.describe Document, type: :model do
  it 'has a valid factory' do
    expect(build(:document)).to be_valid
  end

  describe 'associations' do
    let(:document) { build(:document) }

    it { expect(document).to belong_to(:folder).required(false) }
  end

  describe 'validations' do
    let(:document) { build(:document) }

    it { expect(document).to validate_presence_of(:file) }
    it { expect(document).to validate_length_of(:name).is_at_most(255) }
    it { expect(document).to validate_uniqueness_of(:name).scoped_to(:folder_id).case_insensitive }
  end
end
