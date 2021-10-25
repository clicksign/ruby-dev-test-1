# frozen_string_literal: true

module Contracts
  # Contracts::CreatorProcessor
  class CreatorProcessor
    def self.call(params = {})
      Create.create(params)
    end
  end
end
