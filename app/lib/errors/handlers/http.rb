# frozen_string_literal: true

module Errors
  module Handlers
    module Http
      def self.included(clazz)
        clazz.class_eval do
          rescue_from(StandardError) do |e|
            Errors::Logger.log(self.class, e)
            respond(:internal_server_error, 500, e.to_s)
          end
          rescue_from(ActiveRecord::RecordNotFound) do |e|
            respond(:record_not_found, 404, e.to_s)
          end
          rescue_from(ActiveModel::ValidationError, ActiveRecord::RecordInvalid) do |e|
            respond(:bad_request, 400, e.to_s)
          end
        end
      end

      private

      def respond(_error, status, message)
        render(json: { error: { message: } }, status:)
      end
    end
  end
end
