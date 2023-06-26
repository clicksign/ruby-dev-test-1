class DirectorySearch < ApplicationSearch
  # attributes
  ATTRIBUTES = %i[
    name
    parent_id
    sort
    q
  ].freeze

  ATTRIBUTES.each { |attr| attribute attr }

  # finders
  finder :by_name, requires: :name
  finder :by_parent_id, requires: :parent_id
  finder :fuzzy, requires: :q

  # finder methods
  def by_name
    where name: name
  end

  def by_parent_id
    where parent_id: parent_id
  end

  def fuzzy
    fuzzy_search q
  end
end
