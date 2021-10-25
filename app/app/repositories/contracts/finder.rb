# frozen_string_literal: true

module Contracts
  # Contracts::Finder
  class Finder
    def self.find(params)
      Contracts::Poro.new Contract.find_by(params)
    end
  end
end
