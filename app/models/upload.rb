class Upload < ApplicationRecord
  include ActiveModel::Validations

  validates_with UploadListValidation
  validates :title, presence: true
  has_many_attached :file

  # scope :just_now , -> { where() }

end
