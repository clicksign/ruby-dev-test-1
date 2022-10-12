class ImageFile < ApplicationRecord
  belongs_to :directory

  has_one_attached :document

  validate :verify_document_present
  validate :verify_document_type

  after_create :add_default_name

  def alternative_name
    "document_#{self.id}_#{self.directory_id || 0}"
  end

  def pdf?
    document.content_type == 'application/pdf'
  end

  private

  def verify_document_present
    errors.add(:document, 'não pode ficar em branco.') unless self.document.present?
  end

  def verify_document_type
    if document.attached? && !document.content_type.in?(%w(application/pdf image/png image/jpeg image/jpg))
      document.purge
      errors.add(:document, 'deve ser do tipo: JPG, JPEG, PNG ou PDF.')
    end
  end

  def add_default_name
    self.update(name: alternative_name) if self.name.blank?
  end
end
