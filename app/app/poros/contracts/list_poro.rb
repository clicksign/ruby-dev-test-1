module Contracts
  class ListPoro
    attr_accessor :list

    def initialize(contracts)
      @list = contracts.map do |contract|
        Contracts::Poro.new contract
      end
    end
  end
end
