class Directory < ApplicationRecord
  belongs_to :parent_directory, class_name: 'Directory', optional: true
  has_many :sub_directories, class_name: 'Directory', foreign_key: 'parent_directory_id', dependent: :destroy

  has_many :image_files, dependent: :destroy

  after_create :add_default_name

  def directory_informations
    (self.sub_directories.pluck(:name) + self.image_files.pluck(:name)).join(' + ')
  end

  private

  def add_default_name
    self.update(name: "directory_#{self.id}")
  end
end
