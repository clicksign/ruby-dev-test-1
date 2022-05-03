class Directory < ApplicationRecord
  belongs_to :folder
  belongs_to :sub_folder
end
