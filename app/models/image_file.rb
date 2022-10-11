class ImageFile < ApplicationRecord
  belongs_to :directory

  has_one_attached :image

  validate :verify_image
  after_create :add_default_name

  def alternative_name
    "image_#{self.id}_#{self.directory_id || 0}"
  end

  private

  def verify_image
    errors.add(:image, 'não pode ficar em branco.') unless self.image.present?
  end

  def add_default_name
    self.update(name: alternative_name) if self.name.blank?
  end
end
