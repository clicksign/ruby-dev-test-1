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
class Storable < ApplicationRecord
  belongs_to :parent, -> { where(type: 'Directory') }, class_name: 'Storable', optional: true

  validates :name, presence: true, uniqueness: { scope: :parent_id, case_sensitive: false }
end
