# frozen_string_literal: true

module Contracts
  class Create
    def self.create(params)
      Contracts::Poro.new Contract.create!(params)
    end
  end
end
