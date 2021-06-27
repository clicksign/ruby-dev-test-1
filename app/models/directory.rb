class Directory < ApplicationRecord
  include Rails.application.routes.url_helpers

  has_many :subdirectories, dependent: :destroy
  has_many_attached :archives

  validates :name, presence: true

  def archive_urls
    self.archives&.map { |a| url_for(a) }
  end
end
