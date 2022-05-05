class Folder < ApplicationRecord
  attr_accessor :folder_id_form_url

  has_many :directories
  has_many :sub_folders, through: :directories
  has_many_attached :documents
end
