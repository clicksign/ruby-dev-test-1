class Directory < ApplicationRecord
  # null parent means it is a root directory.
  belongs_to :parent, class_name: 'Directory', optional: true
  has_many :directories, foreign_key: :parent_id
end
