class FileSystemItem < ApplicationRecord
  has_ancestry

  validates_presence_of :name, :kind
  validates :temp_file, presence: true, if: :file?
  validate :validate_name_format, :validate_path

  after_create :store_item

  attr_accessor :temp_file

  enum kind: { folder: 0, file: 1 }

  def complete_path
    self.path.any? ? self.path.pluck(:name).join('/') : self.name
  end

  def absolute_path
    Rails.root + "storage" + self.complete_path
  end

  private

  def validate_name_format
    if /\/|\*/.match?(self.name)
      errors.add(:name, "invalid name format")
    end
  end

  def validate_path
    if self.parent.present? && self.parent.file?
      errors.add(:ancestry, "invalid path")
    end
  end

  def store_item
    if self.file?
      FileUtils.cp self.temp_file, absolute_path
    else
      FileUtils.mkdir_p(absolute_path)
    end
  end
end