# frozen_string_literal: true

module Nameable
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
    validates :name, length: { maximum: 250 }
    validates :name, uniqueness: { scope: 'parent_id' }
    validates :name, format: { without: /\A[\/\s]/ }
  end
end