class TheFile < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  belongs_to :directory
end
