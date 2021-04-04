class TheFile < ApplicationRecord
  validates :name, presence: true, allow_blank: false
  belongs_to :directory

  def get_file_url
    url_for(self.name)
  end
end
