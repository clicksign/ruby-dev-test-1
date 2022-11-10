class Upload < ApplicationRecord
  include ActiveModel::Validations
  validates_with UploadListValidation

  has_many_attached :file

  validates :title, presence: true

  # Person.create(name: "John Doe").valid?
  # scope :just_now , -> { where() }

  def is_multiple?
    result = true

    result
  end

  def size_list
    if ! (valid...)
      self.errors[:base] << "Custom error message"
    end
  end

end
