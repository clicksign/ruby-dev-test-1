class Folder < ApplicationRecord
  validates :label, presence: true
end
