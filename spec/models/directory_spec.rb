
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Directory, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:parent).class_name('Directory').with_foreign_key('directory_id').optional }
    it { is_expected.to have_many(:subfolders).class_name('Directory') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
