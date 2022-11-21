# frozen_string_literal: true

# == Schema Information
#
# Table name: storables
#
#  id         :bigint           not null, primary key
#  name       :citext
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#
# Indexes
#
#  index_storables_on_name                (name) UNIQUE WHERE (parent_id IS NULL)
#  index_storables_on_name_and_parent_id  (name,parent_id) UNIQUE
#  index_storables_on_parent_id           (parent_id)
#  index_storables_on_type                (type)
#
require 'rails_helper'

RSpec.describe Archive, type: :model do
  describe 'associations' do
    it { is_expected.to have_one_attached(:file) }
  end
end
