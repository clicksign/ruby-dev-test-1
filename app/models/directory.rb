class Directory < ApplicationRecord
  has_many :directories,
           class_name: 'Directory',
           foreign_key: :directory_id

  belongs_to :directory,
             class_name: 'Directory',
             optional: true

  validates_presence_of :name

  before_destroy :clean_subdirectories

  private

  def clean_subdirectories
    directories.destroy_all
  end
end