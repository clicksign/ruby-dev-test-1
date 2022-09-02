class Folder < ApplicationRecord
    belongs_to :parent, class_name: 'Folder', optional: true
    has_many :sub_folders, foreign_key: 'parent_id', class_name: 'Folder', dependent: :destroy
    has_many :uploads, dependent: :destroy
    
    validates :name, presence: true, uniqueness: { scope: :parent }    
end
