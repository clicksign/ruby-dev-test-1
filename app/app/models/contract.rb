class Contract < ApplicationRecord
  belongs_to :user
  mount_uploader :file, ContractUploader

  validates_with ContractFileValidator
end
