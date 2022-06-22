class Archive < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 250 }
  validates :name, uniqueness: { scope: 'directory_id' }
  validates :name, format: { without: /\A[\/\s]/ }
  validate :check_file_attached

  belongs_to :directory

  has_one_attached :file

  before_validation :update_full_path

  def update_full_path
    self.full_path = if directory
                       "#{directory.full_path}/#{name}"
                     else
                       "/#{name}"
                     end
  end

  private

  def check_file_attached
    errors.add(:file, 'Please upload the file.') unless file.attached?
  end
end
