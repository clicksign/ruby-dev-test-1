class Directory < ApplicationRecord
  has_ancestry
  has_many_attached :files
  validates :name, presence: true
  # Single node has no parent. Others must be connected to the tree.
  validates :ancestry, uniqueness: true, if: -> {
    ancestry.blank?
  }
  # We need to act after commit due do ancestry. Figuring out who the actual siblings are
  # is only viable after save, so we use after commit for safety.
  after_commit :rename_conflicts

  def name_ancestors(and_self: false)
    ancestors.map { |ancestor| ancestor.name }.join('/').concat(and_self ? "/#{name}" : '')
  end

  def update(attributes)
    if attributes.include?(:name) and (attributes.include?(:parent) || attributes.include?(:parent_id))
      errors.add("Update either parent or name at a time, not both")
      throw(:abort)
    end
    super
  end

  private

  def rename_conflicts
    if siblings.where(name: self.name).count == 2
      update(name: self.name + '(2)')
    end
  end
end