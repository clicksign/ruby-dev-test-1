module Contracts
  class Poro
    attr_accessor :id, :file, :description

    def initialize(contract)
      @id = contract.id
      @description = contract.description
      @file = contract.file.url
    end
  end
end
