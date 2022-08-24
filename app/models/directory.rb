class Directory < ApplicationRecord

  belongs_to :directory, foreign_key: :parent_id, optional: true
  alias parent directory

  has_many :children, foreign_key: :parent_id, class_name: 'Directory'

  has_many_attached :files
end
