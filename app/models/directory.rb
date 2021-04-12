class Directory < ApplicationRecord
  include AttachmentExtended
  
  has_ancestry
  has_many_attached :files

  validates :name, presence: true, uniqueness: { scope: :ancestry }
end
