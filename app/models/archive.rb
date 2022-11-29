class Archive < ApplicationRecord
  belongs_to :directory
  has_one_attached :file

  validates :name, :file, :directory, presence: true
  validates_uniqueness_of :name, scope: :directory_id
  validate :files_type

  private

  def files_type
    return unless file.attached?

    types = ['image/jpeg', 'image/png', 'text/plain']
    types.include?(file.content_type) || errors.add(:file, 'File type invalid!')
  end
end
