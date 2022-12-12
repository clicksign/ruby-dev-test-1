# frozen_string_literal: true

module Api
  module ExceptionHandler
    extend ActiveSupport::Concern

    included do
      rescue_from StandardError do |e|
        case e
        when ActiveRecord::RecordNotFound
          json_error_response(e.message, :not_found)
        when ActiveRecord::RecordInvalid
          json_error_response(e.message, :unprocessable_entity)
        when ActiveInteraction::InvalidInteractionError
          json_error_response(e.message, :bad_request)
        else
          json_error_response("Something went really bad. Contact support: #{e.message}", :internal_server_error)
        end
      end
    end
  end
end
