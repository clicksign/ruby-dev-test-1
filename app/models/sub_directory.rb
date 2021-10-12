class SubDirectory < ApplicationRecord
  has_many :archives, dependent: :destroy

  def self.get_dir(directory)
    if directory.present?
      dir = SubDirectory.new
      dir.name = directory.split('/').last
      dir.path = directory
      dir
    end
  end
end
