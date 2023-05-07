class Document < ApplicationRecord
  belongs_to :folder

  validates :name, :folder, :storage_method, presence: true
  validates :name, uniqueness: { scope: :folder }

  before_save :content_stored?
  before_destroy :destroy_content

  def upload(content)
    return false if content.nil? || storage_method.blank? || !valid?

    destroy_content if !key.blank? && storage.content_stored?(key)
    self.key = storage.upload(content)
    save
  end

  def download
    return nil if storage_method.blank?

    storage.download(key)
  end

  def destroy_content
    return nil if key.blank? || storage_method.blank?

    storage.destroy_content(key)
  end

  def content_stored?
    !key.blank? && storage.content_stored?(key)
  end

  private
    def storage
      @storage ||= storage_method.constantize.new
    end
end
