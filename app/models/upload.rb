class Upload < ApplicationRecord
  include ActiveModel::Validations

  validates_with UploadListValidation
  validates :title, presence: true

  has_many_attached :file

  # Person.create(name: "John Doe").valid?
  # scope :just_now , -> { where() }

  def is_multiple?
    result = true

    result
  end

end
