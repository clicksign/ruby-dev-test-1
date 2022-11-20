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
class Directory < Storable
  has_many :storables, class_name: 'Storable', foreign_key: :parent_id
  has_many :archives, -> { where(type: 'Archive') }, class_name: 'Storable', foreign_key: :parent_id
  has_many :subdirectories, -> { where(type: 'Directory') }, class_name: 'Storable', foreign_key: :parent_id
end
