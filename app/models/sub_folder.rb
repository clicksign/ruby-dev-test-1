class SubFolder < ApplicationRecord
  attr_accessor :folder_id_form_url
  has_many :directories
  has_many :folders, through: :directories
end
