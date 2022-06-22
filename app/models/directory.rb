# frozen_string_literal: true

class Directory < ApplicationRecord
  include Nameable

  belongs_to :parent, class_name: 'Directory', optional: true

  has_many :children, class_name: 'Directory', foreign_key: 'parent_id'
  has_many :archives, inverse_of: 'parent', foreign_key: 'parent_id'

  after_validation :update_full_path
  after_update :update_children_full_path
  after_update :update_archives_full_path

  def update_full_path
    return unless name.present?

    self.full_path = if parent
                       "#{parent.full_path}/#{name}"
                     else
                       "/#{name}"
                     end
  end

  def update_full_path!
    update_full_path
    save!
  end

  private

  def update_children_full_path
    children.reload.each(&:update_full_path!)
  end

  def update_archives_full_path
    archives.reload.each(&:update_full_path!)
  end
end
