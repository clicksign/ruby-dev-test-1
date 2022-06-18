class Node < ApplicationRecord
    validates :name, presence: true 
    validate :nodes_cannot_be_duplicate_same_path 
    
    has_many :children, class_name: "Node", foreign_key: "parent_id"
    belongs_to :parent, class_name: "Node", optional: true, foreign_key: "parent_id"
    has_many :assets, dependent: :destroy
    
    def nodes_cannot_be_duplicate_same_path
        if parent_id.present? && Node.where(name: name, parent_id: parent_id).exists?
            errors.add(:name, "already exists with same name and parent")
        elsif Node.where(name: name, parent_id: parent_id).exists? 
            errors.add(:name, "already exists with same name and parent")
        end            
    end
end
