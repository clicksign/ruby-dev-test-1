class Directory < ApplicationRecord
  has_ancestry
  validates :name, presence: true
  validates :ancestry, presence: true, if: -> {
    Directory.any?
  }
  before_save :rename_conflicts
  def name_ancestors(and_self: false)
    if and_self
      return ancestors.map { |ancestor| ancestor.name }.join('/') + "/#{name}"
    end
    ancestors.map { |ancestor| ancestor.name }.join('/')
  end

  private

  def rename_conflicts
    # Use self for clarity. VERY limited solution.
    byebug
    if siblings.where(name: self.name).count == 2
      self.name = self.name + '(2)'
    end
  end
end