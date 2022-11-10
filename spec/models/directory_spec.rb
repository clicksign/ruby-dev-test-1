# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Directory, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:parent_id) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:parent).class_name('Directory').optional }
    it { is_expected.to have_many(:subdirectories).class_name('Directory').with_foreign_key('parent_id').dependent(:destroy) }
    it { is_expected.to have_many(:documents).class_name('Document').dependent(:destroy) }
  end
end
