class ArchiveSearch < ApplicationSearch
  # attributes
  ATTRIBUTES = %i[
    name
    directory_id
    sort
    q
  ].freeze

  ATTRIBUTES.each { |attr| attribute attr }

  # finders
  finder :by_name, requires: :name
  finder :by_directory_id, requires: :directory_id
  finder :fuzzy, requires: :q

  # finder methods
  def by_name
    where name: name
  end

  def by_directory_id
    where directory_id: directory_id
  end

  def fuzzy
    fuzzy_search q
  end
end
