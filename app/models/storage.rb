# frozen_string_literal: true

class Storage < ApplicationRecord
  belongs_to :folder

  validates :name, presence: true, uniqueness: { scope: :folder_id }

  def path
    "#{folder.path}/#{name}"
  end
end
