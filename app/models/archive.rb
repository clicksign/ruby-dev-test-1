# frozen_string_literal: true

class Archive < ApplicationRecord
  acts_as_tenant(:user)

  has_one_attached :file

  belongs_to :folder, optional: true

  validates :name, presence: true, length: { in: 3..60 }, uniqueness: { scope: :user_id }
  validates :file, presence: true

  delegate :url, to: :file

  def path
    return name unless folder

    [folder.path, name].join('/')
  end
end
