# frozen_string_literal: true

class Project < ApplicationRecord
  validates :name, presence: true

  has_many :directories, dependent: :destroy
  belongs_to :user
end
