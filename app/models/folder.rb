# frozen_string_literal: true

class Folder < ApplicationRecord
  belongs_to :parent, class_name: 'Folder', optional: true
  has_many :children, class_name: 'Folder', foreign_key: 'parent_id', dependent: :destroy, inverse_of: :parent

  validates_presence_of :name
  validates :name, uniqueness: { scope: [:parent_id] }

end
