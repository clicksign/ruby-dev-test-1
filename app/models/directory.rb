# annotate
# ---
# == Schema Information
#
# Table name: directories
#
#  id         :uuid             not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :uuid
#  user_id    :uuid             not null
#
# Indexes
#
#  index_directories_on_name_and_parent_id              (name,parent_id) UNIQUE
#  index_directories_on_name_and_parent_id_and_user_id  (name,parent_id,user_id) UNIQUE
#  index_directories_on_parent_id                       (parent_id)
#  index_directories_on_user_id                         (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_id => directories.id)
#  fk_rails_...  (user_id => users.id)
#
# ---
class Directory < ApplicationRecord
  # Pg_Search (Full Text Search)
  # ---
  include PgSearch::Model
  pg_search_scope :fuzzy_search,
                  against: %i[name],
                  associated_against: {
                    parent: %i[name]
                  }

  # Tenant
  # ---
  acts_as_tenant :user

  # Validations
  # ---
  validates :name, presence: true, uniqueness: { scope: [:parent_id, :user_id] }

  # Associations
  # ---
  belongs_to :user
  belongs_to :parent, class_name: "Directory", optional: true
  has_many :sub_dirs, class_name: "Directory", foreign_key: "parent_id", dependent: :destroy
  has_many :archives, dependent: :destroy

  # Virtual Attributes
  # ---
  def path
    return name unless parent

    [parent.path, name].join('/')
  end
end
