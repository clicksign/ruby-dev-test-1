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
class Directory < Storable
  has_many :storables, class_name: 'Storable', foreign_key: :parent_id, inverse_of: :parent, dependent: :destroy
  has_many :archives, lambda {
                        where(type: 'Archive')
                      }, class_name: 'Storable', foreign_key: :parent_id, inverse_of: :parent, dependent: :destroy
  has_many :subdirectories, lambda {
                              where(type: 'Directory')
                            }, class_name: 'Storable', foreign_key: :parent_id, inverse_of: :parent, dependent: :destroy
end
