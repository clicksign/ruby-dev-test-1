require 'rails_helper'

RSpec.describe LocalFile, type: :model do
  context 'attributes' do
    describe '#name' do
      specify { is_expected.to have_db_column(:name).of_type(:string).with_options(null: false) }
    end

    describe '#attached' do
      specify { is_expected.to have_db_column(:attached).of_type(:string).with_options(null: true) }
    end

    describe '#created_at' do
      specify { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    end

    describe '#updated_at' do
      specify { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end
  end

  context 'associations' do
    specify { is_expected.to have_many(:media) }
  end

  context 'validations' do
    specify { is_expected.to validate_presence_of(:name) }
  end
end
