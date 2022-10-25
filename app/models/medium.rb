class Medium < ApplicationRecord
  belongs_to :folder
  belongs_to :fileable, polymorphic: true
end
