# == Schema Information
#
# Table name: folders
#
#  id             :uuid             not null, primary key
#  name           :string(300)      not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  main_folder_id :uuid
#
# Indexes
#
#  index_folders_on_main_folder_id  (main_folder_id)
#  index_folders_on_name            (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (main_folder_id => folders.id)
#
class Folder < ApplicationRecord
  TREE_FOLDER_LIMIT = 50

  # relations
  belongs_to :main_folder, required: false, class_name: 'Folder'
  has_many :sub_folders, foreign_key: :main_folder_id, class_name: 'Folder'
  has_many :archives

  # nested_attributes
  accepts_nested_attributes_for :sub_folders
  accepts_nested_attributes_for :archives

  # validations
  validates :name, uniqueness: { scope: :main_folder_id }, presence: true
  validates_length_of :name, maximum: 300

  # scopes
  scope :tree_folder, lambda { |id|
    Folder.find_by_sql([<<-SQL, id])
      WITH RECURSIVE folder_tree AS (
        SELECT id, main_folder_id, name
        FROM folders
        WHERE id = ?
        UNION ALL
        SELECT f.id, f.main_folder_id, f.name
        FROM folders f
        INNER JOIN folder_tree ft ON f.id = ft.main_folder_id
      )
      SELECT *
      FROM folder_tree
      ORDER BY name ASC
      LIMIT #{TREE_FOLDER_LIMIT}
    SQL
  }

  def full_path
    return name if main_folder_id.blank?

    self.class.tree_folder(id).pluck(:name).join('/')
  end
end
