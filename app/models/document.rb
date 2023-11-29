# frozen_string_literal: true

class Document < ApplicationRecord
  include Associations
  include Validations

  has_one_attached :file
end
