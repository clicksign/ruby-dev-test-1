# frozen_string_literal: true

# == Schema Information
#
# Table name: directories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#
class Directory < ApplicationRecord
  belongs_to :parent, class_name: 'Directory'

  has_many :children,
           class_name: 'Directory',
           foreign_key: 'parent_id',
           inverse_of: :children,
           dependent: :destroy

  has_many :arquives, dependent: :destroy

  scope :top_level, -> { where(parent_id: nil) }
end
