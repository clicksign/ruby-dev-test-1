# frozen_string_literal: true

# == Schema Information
#
# Table name: directories
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#
class Directory < ApplicationRecord
  belongs_to :parent, class_name: 'Directory'

  has_many :children,
           class_name: 'Directory',
           foreign_key: 'parent_id',
           inverse_of: false,
           dependent: :destroy

  has_many :arquives, dependent: :destroy

  scope :top_level, -> { where(parent_id: nil) }

  validates :name, presence: true

  def self_and_descendents
    self.class.tree_for(self)
  end

  def self.tree_for(instance)
    where("#{table_name}.id IN (#{tree_sql_for(instance)})").order("#{table_name}.id")
  end

  def self.tree_sql_for(instance)
    <<-SQL.squish
      WITH RECURSIVE search_tree(id, path) AS (
          SELECT id, ARRAY[id]
          FROM #{table_name}
          WHERE id = #{instance.id}
        UNION ALL
          SELECT #{table_name}.id, path || #{table_name}.id
          FROM search_tree
          JOIN #{table_name} ON #{table_name}.parent_id = search_tree.id
          WHERE NOT #{table_name}.id = ANY(path)
      )
      SELECT id FROM search_tree ORDER BY path
    SQL
  end
end
