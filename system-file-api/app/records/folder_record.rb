# frozen_string_literal: true

class FolderRecord < ApplicationRecord
  self.table_name = 'folders'

  has_many :childrens, class_name: 'FolderRecord',
                       foreign_key: 'folder_id', dependent: :destroy
  has_many :file_items, class_name: 'FileItemRecord',
                        foreign_key: 'folder_id', dependent: :destroy

  belongs_to :parent, class_name: 'FolderRecord', foreign_key: 'folder_id', optional: true
end
