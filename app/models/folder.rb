class Folder < ApplicationRecord
  validates :label, presence: true
  validates :label, uniqueness: { scope: :ancestry, case_sensitive: true }

  has_ancestry
end
