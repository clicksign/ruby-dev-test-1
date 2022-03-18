class Document < ApplicationRecord
  validates :name, presence: true, uniqueness: { scope: :folder_id, case_sensitive: false }
  validates :origin, presence: true

  belongs_to :folder, required: false

  default_scope { order(:name) }

  enum origin: { blob: 1, s3: 2, local: 3 }
end
