# frozen_string_literal: true

class Document < ApplicationRecord
  module Validations
    extend ActiveSupport::Concern
    included do
      validates :name, presence: true, uniqueness: true
      validates :file, presence: true
    end
  end
end
