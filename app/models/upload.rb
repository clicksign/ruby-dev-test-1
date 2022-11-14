class Upload < ApplicationRecord
  include ActiveModel::Validations

  has_many_attached :file
  validates :title, presence: true
  before_save :attach_file
  # validates_with UploadListValidation

  def attach_file
    puts "model before save"
  end

end
