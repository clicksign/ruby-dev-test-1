class Directory < ApplicationRecord
  has_many :directories,
           class_name: 'Directory',
           foreign_key: :directory_id

  belongs_to :directory,
             class_name: 'Directory',
             optional: true

  validates_presence_of :name
end