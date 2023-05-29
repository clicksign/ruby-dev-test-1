# frozen_string_literal: true

require 'rails_helper'

RSpec.describe File::S3, type: :model do
  describe 'associations' do
    it { should belong_to(:folder) }
  end

  describe 'attachments' do
    it { should have_one_attached(:attachment) }
  end
end
