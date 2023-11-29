# frozen_string_literal: true

class Folder < ApplicationRecord
  module Validations
    extend ActiveSupport::Concern
    included do
      validates :name, presence: true, uniqueness: { scope: :parent }
    end
  end
end
