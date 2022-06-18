class Asset < ApplicationRecord
    belongs_to :node
    has_one_attached :file

    validate :assets_cannot_be_duplicate_same_path 

    def assets_cannot_be_duplicate_same_path
        if node_id.present? && Asset.where(name: name, node_id: node_id).exists?
            errors.add(:name, "already exists with same file name")
        elsif Asset.where(name: name, node_id: node_id).exists?
            errors.add(:name, "already exists with same file name")
        end            
    end
end
