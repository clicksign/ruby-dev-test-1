class Node < ApplicationRecord
    validates :name, presence: true 
    validate :nodes_cannot_be_duplicate_same_path 
    
    def nodes_cannot_be_duplicate_same_path
        if parent_id.present? && Node.where(name: name, parent_id: parent_id).exists?
            errors.add(:name, "already exists with same name and parent")
        elsif Node.where(name: name, parent_id: parent_id).exists? 
            errors.add(:name, "already exists with same name and parent")
        end            
    end
end
