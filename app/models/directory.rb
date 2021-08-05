class Directory < ApplicationRecord
  has_ancestry
  validates :name, presence: true
  validates :ancestry, presence: true, if: -> {
    Directory.any?
  }
  def name_ancestors(and_self: false)
    if and_self
      return ancestors.map { |anc| anc.name }.join('/') + "/#{name}"
    end
    ancestors.map { |anc| anc.name }.join('/')
  end
end