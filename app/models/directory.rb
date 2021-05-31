class Directory < ApplicationRecord
  has_ancestry
  has_many_attached :files

  validates :name, presence: true, uniqueness: { scope: :ancestry }

  before_validation do
    assign_attributes(ancestry: '1') if ancestry.blank? && name != 'root'
  end
end
