# == Schema Information
#
# Table name: directories
#
#  id         :bigint           not null, primary key
#  ancestry   :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_directories_on_ancestry  (ancestry)
#
class Directory < ApplicationRecord
  has_ancestry
  has_many :aws_files, dependent: :destroy

  before_destroy :delete_children

  validates :name, presence: true

  def parent_names(ancestors)
    Directory.where(id: ancestors).pluck(:name)
  end

  private

  def delete_children
    self.children.each do |child|
      child.destroy
    end
  end
end
