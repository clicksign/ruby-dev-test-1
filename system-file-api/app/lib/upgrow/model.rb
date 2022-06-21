# frozen_string_literal: true

module Upgrow
  # Models are objects that represent core entities of the app’s business logic.
  # These are usually persisted and can be fetched and created as needed. They
  # have unique keys for identification (usually a numeric value), and, most
  # importantly perhaps, they are immutable. This is the key difference between
  # this new Model layer of objects and the Active Record instances regularly
  # referred to as models in typical Rails default apps.
  #
  # Another difference between Models and Records is that, once instantiated,
  # Models simply hold its attributes immutably, and they don’t have any
  # capabilities to create or update any information in the persistence layer.
  #
  # The collaboration between Repositories and Models is what allows Active
  # Record to be completely hidden away from any other areas of the app. There
  # are no references to Records in controllers, views, and anywhere else.
  # Repositories are invoked instead, which in turn return read-only Models.
  class Model < ImmutableObject
    attribute :id
    attribute :created_at
    attribute :updated_at

    # Initializes a new Model with the given member values.
    #
    # @param args [Hash<Symbol, Object>] the list of values for each attribute.
    #
    # @raise [KeyError] if an attribute is missing in the list of arguments.
    def initialize(**args)
      self.class.attribute_names.filter { |a| a[:required] }.each { |key| args.fetch(key[:name]) }

      super
    end

    def to_json(*_args)
      attributes.to_json
    end
  end
end
