class Folder < ApplicationRecord
  validates :document, presence: :true
  validate :parent_exist?

  def parent_exist?
    return true if self.parent_id.nil?
    
    unless Folder.where(parent_id: self.parent_id).count > 0
      errors.add(:parent_id, "can't be in the past")
      return false
    end

    return true
  end
end
