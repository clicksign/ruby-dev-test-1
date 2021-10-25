class Directory < ApplicationRecord
  has_many :archives
  # has_many :subdirectories, class_name: 'Directory', foreign_key: :id
end
