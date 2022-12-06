
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Directory, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:parent).class_name('Directory').with_foreign_key('directory_id').optional }
    it { is_expected.to have_many(:subdirectories).class_name('Directory') }
    it { is_expected.to have_many(:documents) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
