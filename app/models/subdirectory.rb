class Subdirectory < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :directory
  has_many_attached :archives

  validates :name, presence: true

  def archive_urls
    self.archives&.map { |a| url_for(a) }
  end
end
