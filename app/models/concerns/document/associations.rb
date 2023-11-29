# frozen_string_literal: true

class Document < ApplicationRecord
  module Associations
    extend ActiveSupport::Concern
    included do
      belongs_to :folder
    end
  end
end
