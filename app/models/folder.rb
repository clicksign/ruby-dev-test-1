# frozen_string_literal: true

class Folder < ApplicationRecord
  acts_as_tenant(:user)

  belongs_to :parent, class_name: :Folder, foreign_key: :parent_folder_id, optional: true
  has_many :sub_folders, class_name: :Folder, foreign_key: :parent_folder_id
  has_many :archives

  validates :name, presence: true, length: { in: 3..30 }, uniqueness: { scope: :user_id }

  def path
    return name unless parent

    [parent.path, name].join('/')
  end
end
