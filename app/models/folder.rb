class Folder < ApplicationRecord
    validates :name, presence: true
    belongs_to :parent, class_name: "Folder", optional: true
    has_many :folders, class_name: "Folder", foreign_key: "parent_id", dependent: :destroy
end
