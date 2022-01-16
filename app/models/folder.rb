class Folder < ApplicationRecord
    belongs_to :parent, class_name: "Folder", optional: true
    has_many :folders, class_name: "Folder", foreign_key: "parent_id", dependent: :destroy
    has_many_attached :files

    validates :name, presence: true

    # Method created to match the files specification
    # which has a rename method too
    def rename folder_name
        self.update(name: folder_name)
    end

    # Method created to match the files specification
    # which has a move method too
    def move folder_name
        self.update(parent_id: folder_name.id)
    end

    def children
        self.folders + self.files
    end

    def path
        if self.parent
            "#{self.parent.path}/#{self.name}"
        else
            self.name
        end
    end
end
