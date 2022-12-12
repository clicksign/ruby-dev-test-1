# frozen_string_literal: true

class ArchiveSerializer < BaseSerializer
  fields :id, :name, :size

  field :document_url do |stored|
    url_for(stored.document)
  end
end
