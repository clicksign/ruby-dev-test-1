class Archive < ApplicationRecord
  validates :name, presence: true
  validates :name, length: { maximum: 250 }
  validates :name, uniqueness: { scope: 'parent_id' }
  validates :name, format: { without: /\A[\/\s]/ }
  validate :check_file_attached

  belongs_to :parent, class_name: 'Directory', inverse_of: 'archives'

  has_one_attached :file

  before_validation :update_full_path

  def update_full_path
    self.full_path = if parent
                       "#{parent.full_path}/#{name}"
                     else
                       "/#{name}"
                     end
  end

  private

  def check_file_attached
    errors.add(:file, 'Please upload the file.') unless file.attached?
  end
end
