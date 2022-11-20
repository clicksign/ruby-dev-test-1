# frozen_string_literal: true

# == Schema Information
#
# Table name: storables
#
#  id         :bigint           not null, primary key
#  name       :string
#  type       :string
#  parent_id  :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Archive, type: :model do
  describe 'associations' do
    it { is_expected.to have_one_attached(:file) }
  end
end
