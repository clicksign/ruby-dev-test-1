class Document < ApplicationRecord
  belongs_to :directory
  has_one_attached :attached_content
  validates :name, presence: true
  validates :content, presence: true, if: :database?

  enum storage_type: { database: 'database', disk: 'disk', s3: 's3' }

  before_save :update_attached_content_key, unless: :database?

  def assign_content(file_path)
    if database?
      self.content = File.read file_path
    else
      io = File.open file_path
      filename = file_path.match(%r{/([^/]+)$})[1]
      attached_content.attach(io:, filename:)
    end
  end

  private

  def update_attached_content_key
    attached_content.service_name = storage_type.to_sym

    return unless attached_content.attached?

    key = "#{directory.full_path}/#{name}.#{SecureRandom.uuid}"
    attached_content.blob.update key:
  end
end
