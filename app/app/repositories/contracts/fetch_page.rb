# frozen_string_literal: true

module Contracts
  # Contracts::FetchPage
  class FetchPage
    def self.list(page: nil, user_id:)
      Contracts::ListPoro.new contracts_by(user_id: user_id).page(page || 1).per(25)
    end

    def self.contracts_by(user_id:)
      Contract.where(user_id: user_id)
    end
  end
end
