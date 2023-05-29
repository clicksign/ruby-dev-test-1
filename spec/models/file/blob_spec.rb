# frozen_string_literal: true

require 'rails_helper'

RSpec.describe File::Blob, type: :model do
  describe 'associations' do
    it { should belong_to(:folder) }
  end

  describe 'validations' do
    subject { build(:file_blob) }

    it { should validate_presence_of(:file_data) }
  end
end