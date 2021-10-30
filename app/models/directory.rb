class Directory < ApplicationRecord
    has_many_attached :files
end
