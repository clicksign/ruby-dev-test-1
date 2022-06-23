require 'rails_helper'

RSpec.describe Archive, type: :model, focus: true do
  describe 'ActiveRecord validations' do
    it { is_expected.to belong_to(:folder).optional }
    it { is_expected.to have_db_index('name, COALESCE(folder_id, (0)::bigint)').unique(true) }
    it { is_expected.to have_one_attached(:data) }
  end

  describe 'ActiveModel validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_length_of(:name).is_at_least(3).is_at_most(64) }

    it do
      expect(described_class.new).to validate_numericality_of(:size)
        .only_integer.is_greater_than_or_equal_to(0)
    end
  end
end
