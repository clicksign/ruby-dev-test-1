class Directory < ApplicationRecord
  belongs_to :parent
  has_many_attached :files
end
