# frozen_string_literal: true

class Directory < ApplicationRecord
  has_ancestry
  has_many_attached :files

  validates_presence_of :name
  validates :name, uniqueness: { case_sensitive: false, scope: %i[ancestry] }
  validates :name, length: { maximum: 100 }
  validates :name, format: { with: /\A^[a-zA-Z]+[a-zA-Z0-9\s](\s+[^\s]+)*$\Z/ }

  before_validation :build_slug

  def path
    super.map(&:slug).join('/')
  end

  private

  def build_slug
    self.slug = name.try(:parameterize)
  end
end
