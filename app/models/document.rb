class Document < ApplicationRecord
    belongs_to :folder, optional: true
    mount_uploader :path, AttachmentUploader # Tells rails to use this uploader for this model.
    validates :name, presence: true
 end
