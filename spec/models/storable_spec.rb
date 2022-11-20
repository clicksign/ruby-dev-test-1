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

RSpec.describe Storable, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:parent).conditions(type: 'Directory').class_name('Storable').optional }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:parent_id).case_insensitive }
  end
end
