# frozen_string_literal: true

##
# Represents a directory in a file system.
# Each directory can have subdirectories and files.
class Directory < ApplicationRecord
  belongs_to :parent,
             class_name: "Directory",
             counter_cache: :subdirectories_count,
             inverse_of: :subdirectories,
             optional: true

  has_many :subdirectories,
           class_name: "Directory",
           foreign_key: :parent_id,
           inverse_of: :parent,
           dependent: :destroy

  has_many_attached :files

  validates :name,
            presence: true,
            uniqueness: { scope: :parent_id },
            length: { maximum: 255 }

  validate :validates_self_referenced
  validate :validates_parent_is_a_subdirectory

  ##
  # Search all subdirectories of instance
  #
  # @param [Directory] instance
  # @return [Directory::ActiveRecord_Relation]
  def self.descendants_of(instance)
    return instance.subdirectories if instance.new_record?

    where("#{table_name}.id IN (#{sql_for_descendants(instance.id)})")
  end

  ##
  # SQL for search subdirectories of a directory
  #
  # @param [Integer] directory_id
  # @return [String]
  def self.sql_for_descendants(directory_id)
    <<-SQL.squish
      WITH RECURSIVE directory_tree(id, path) AS (
          SELECT id, ARRAY[id] as path FROM directories WHERE id = #{directory_id}
          UNION
          SELECT subdirectories.id, path || subdirectories.id FROM directories subdirectories
            INNER JOIN directory_tree parent_directory ON parent_directory.id = subdirectories.parent_id
      ) SELECT id FROM directory_tree WHERE id <> #{directory_id}
    SQL
  end

  private

  def validates_self_referenced
    errors.add(:parent_id, :self_referenced) if parent == self
  end

  def validates_parent_is_a_subdirectory
    return if new_record? || parent.blank? || self.class.descendants_of(self).where(id: parent_id).none?

    errors.add(:parent_id, :parent_is_a_subdirectory)
  end
end
