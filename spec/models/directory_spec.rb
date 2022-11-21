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

RSpec.describe Directory, type: :model do
  describe 'associations' do
    it 'return storables' do
      is_expected.to(
        have_many(:storables)
          .class_name('Storable')
          .with_foreign_key(:parent_id).inverse_of(:parent).dependent(:destroy)
      )
    end

    it 'return archives' do
      is_expected.to(
        have_many(:archives)
          .conditions(type: 'Archive')
          .class_name('Storable').with_foreign_key(:parent_id).inverse_of(:parent).dependent(:destroy)
      )
    end

    it 'return subdirectories' do
      is_expected.to(
        have_many(:subdirectories)
          .conditions(type: 'Directory')
          .class_name('Storable').with_foreign_key(:parent_id).inverse_of(:parent).dependent(:destroy)
      )
    end
  end
end
