class Folder < ApplicationRecord
    belongs_to :folder, optional: true
    has_many :documents
    scope :nameAsc, -> {order('name asc')}
    validates :name, presence: true
end
