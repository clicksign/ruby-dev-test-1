# frozen_string_literal: true

class Directory < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 250 }
  validates :name, uniqueness: { scope: 'parent_dir_id' }
  validates :name, format: { without: /\A[\/\s]/ }

  belongs_to :parent_dir, class_name: 'Directory', optional: true, inverse_of: 'child_dirs'

  has_many :child_dirs, class_name: 'Directory', foreign_key: 'parent_dir_id', inverse_of: 'parent_dir'

  before_validation :update_full_path
  after_update :update_children_full_path

  def update_full_path
    self.full_path = if parent_dir
                       "#{parent_dir.full_path}/#{name}"
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
    child_dirs.reload.each(&:update_full_path!)
  end
end
