class Folder < ApplicationRecord
  has_many :archives, dependent: :destroy

  belongs_to :parent, class_name: 'Folder', optional: true
  has_many :sub_folders, class_name: 'Folder', foreign_key: :parent_id, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :parent }

  validate :self_reference

  def self_reference
    return if id.nil? || id != parent_id

    errors.add(:self_reference, 'Folder must not self-reference')
  end
end
