require 'rails_helper'

RSpec.describe Medium, type: :model do
  context 'attributes' do
    describe '#folder_id' do
      specify { is_expected.to have_db_column(:folder_id).of_type(:integer).with_options(null: false) }
    end

    describe '#fileable_type' do
      specify { is_expected.to have_db_column(:fileable_type).of_type(:string).with_options(null: false) }
    end

    describe '#fileable_id' do
      specify { is_expected.to have_db_column(:fileable_id).of_type(:integer).with_options(null: false) }
    end

    describe '#created_at' do
      specify { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
    end

    describe '#updated_at' do
      specify { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end
  end

  context 'associations' do
    specify { is_expected.to belong_to(:folder) }
    specify { is_expected.to belong_to(:fileable) }
  end
end
