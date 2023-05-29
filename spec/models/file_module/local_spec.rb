# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FileModule::Local do
  describe 'associations' do
    it { is_expected.to belong_to(:folder) }
  end

  describe 'attachments' do
    it { is_expected.to have_one_attached(:attachment) }
  end
end
