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

RSpec.describe Directory, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:storables).class_name('Storable').with_foreign_key(:parent_id) }
    it { is_expected.to have_many(:archives).conditions(type: 'Archive').class_name('Storable').with_foreign_key(:parent_id) }
    it { is_expected.to have_many(:subdirectories).conditions(type: 'Directory').class_name('Storable').with_foreign_key(:parent_id) }
  end
end
