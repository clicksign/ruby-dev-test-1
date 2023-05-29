# frozen_string_literal: true

require 'rails_helper'

RSpec.describe File::S3, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:folder) }
  end

  describe 'attachments' do
    it { is_expected.to have_one_attached(:attachment) }
  end
end
