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
class Storable < ApplicationRecord
  belongs_to :parent, lambda {
                        where(type: 'Directory')
                      }, class_name: 'Storable', foreign_key: :parent_id, optional: true

  validates :name, presence: true, uniqueness: { scope: :parent_id, case_sensitive: false }

  validates_with ParentValidator
end
