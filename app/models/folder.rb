class Folder < ApplicationRecord
  belongs_to :parent, class_name: Folder.name, optional: true
  has_many :children, class_name: Folder.name, foreign_key: :parent_id, dependent: :destroy
  has_many_attached :files, dependent: :destroy

  validates :name, presence: true
  validates_presence_of :parent, if: :parent_id?
  validates_with FolderSubfolderValidator, on: :update

  scope :root_level, -> { where(parent_id: nil) }

  def self.subtree_sql_children(instance)
    "
    WITH RECURSIVE search_tree(id, path) AS (
      SELECT id, ARRAY[id]
      FROM #{table_name}
      WHERE id = #{instance.id}
    UNION ALL
      SELECT #{table_name}.id, path || #{table_name}.id
      FROM search_tree
      JOIN #{table_name} ON #{table_name}.parent_id = search_tree.id
      WHERE NOT #{table_name}.id = ANY(path)
  ) SELECT * from #{table_name} where #{table_name}.id in (SELECT id FROM search_tree ORDER BY path)
    "
  end

  def subtree_children
    Folder.find_by_sql(self.class.subtree_sql_children(self))
  end

  private

  def parent_id?
    parent_id.present?
  end
end
