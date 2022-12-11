# frozen_string_literal: true

class BaseInteraction < ActiveInteraction::Base
  UUIDV4 = /\A[0-9A-F]{8}-[0-9A-F]{4}-4[0-9A-F]{3}-[89AB][0-9A-F]{3}-[0-9A-F]{12}\Z/i

  def within_transaction
    ActiveRecord::Base.transaction do
      yield
    rescue StandardError => e
      raise ActiveInteraction::InvalidInteractionError, e.message
    end
  end
end
