class Directory < ApplicationRecord
  belongs_to :parent_directory, class_name: 'Directory', optional: true
  has_many :sub_directories, class_name: 'Directory', foreign_key: 'parent_directory_id'

  has_many :image_files

  after_create :add_default_name
  after_destroy :destroy_related

  def directory_informations
    (self.sub_directories.pluck(:name) + self.image_files.pluck(:name)).join(' + ')
  end

  private

  def add_default_name
    self.update(name: "directory_#{self.id}")
  end

  def destroy_related
    self.sub_directories.destroy_all if self.sub_directories.any?
    self.image_files.destroy_all if self.image_files.any?
  end
end
