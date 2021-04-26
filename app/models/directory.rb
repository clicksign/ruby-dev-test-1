class Directory < ApplicationRecord
  has_many :archives

  has_many :directories,
           class_name: 'Directory',
           foreign_key: :directory_id

  belongs_to :directory,
             class_name: 'Directory',
             optional: true

  validates_presence_of :name, allow_bank: false

  validate :is_a_valid_directory?, if: :directory_id?

  before_destroy :clean_subdirectories

  private

  def clean_subdirectories
    if directories.any?
      directories.each do |directory|
        directory.archives.destroy_all if directory.archives.any?
        directory.destroy
      end
    end
  end

  def is_a_valid_directory?
    errors.add(:directory_id, 'is invalid') unless Directory.exists?(self.directory_id)
  end
end