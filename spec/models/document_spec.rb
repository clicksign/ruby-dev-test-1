
# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Document, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:directory).optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
