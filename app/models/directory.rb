class Directory < ApplicationRecord
    has_many_attached :files
    has_many :subdirectories, class_name: "Directory", foreign_key: "ref_directory_id"
    #ref alias reference
    belongs_to :ref_directory, class_name: "Directory", optional: true
    #Scopes
    scope :borders, -> { where(ref_directory_id: nil) }


    def no_result?
        return true if (self.files.size < 1 and self.subdirectories.size < 1)
        false
    end
end
