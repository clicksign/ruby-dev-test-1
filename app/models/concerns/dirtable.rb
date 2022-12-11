# frozen_string_literal: true

module Dirtable
  extend ActiveSupport::Concern

  included do
    validates :dirname, presence: true, uniqueness: { scope: :parent_id }
  end
end
