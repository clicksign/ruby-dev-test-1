# frozen_string_literal: true

class Archive < ApplicationRecord
  belongs_to :folder
  has_many_attached :files, dependent: :destroy
end
