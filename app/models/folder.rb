class Folder < ApplicationRecord
  has_many :local_files
  has_many :files, as: :fileable

  validates :label, presence: true
  validates :label, uniqueness: { scope: :ancestry, case_sensitive: true }

  has_ancestry
end
