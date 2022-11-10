# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:content) }
    it { is_expected.to validate_presence_of(:directory) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:directory).class_name('Directory') }
    it { is_expected.to have_one_attached(:content) }
  end
end
