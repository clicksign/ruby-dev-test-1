class Document < ApplicationRecord
  belongs_to :directory
  validates :name, presence: true
  validates :content, presence: true, if: :database?

  enum storage_type: { database: 'database', disk: 'disk', s3: 's3' }
end
