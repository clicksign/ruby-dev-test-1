# frozen_string_literal: true

class Folder < ApplicationRecord
  has_many :subfolders, class_name: 'Folder',
                        foreign_key: 'ref_id', dependent: :delete_all
  belongs_to :ref, class_name: 'Folder', optional: true

  validates_presence_of :name
  validates :name, uniqueness: { scope: :ref_id }
end
