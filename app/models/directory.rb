class Directory < ApplicationRecord
  has_ancestry
  validates :name, presence: true
  validates :ancestry, presence: true, if: -> {
    Directory.any?
  }
  after_commit :rename_conflicts

  def name_ancestors(and_self: false)
    ancestors.map { |ancestor| ancestor.name }.join('/').concat(and_self ? "/#{name}" : '')
  end

  def update(attributes)
    # Oh boy. I will claim this improves readability.
    if attributes.include?(:name) and (attributes.include?(:parent) || attributes.include?(:parent_id))
      errors.add("Update either parent or name at a time, not both")
      throw(:abort)
    end
    super
  end

  private

  def rename_conflicts
    # Use self for clarity. VERY limited solution.
    if siblings.where(name: self.name).count == 2
      update(name: self.name + '(2)')
    end
  end
end