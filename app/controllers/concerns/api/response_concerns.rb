# frozen_string_literal: true

module Api
  module ResponseConcerns
    def json_error_response(messages, status = :unprocessable_entity)
      body = json_response_body('failure', messages)
      render status:, json: body
    end

    def json_success_response(object, status = :ok)
      body = json_response_body('success', [], object)
      render status:, json: body
    end

    def json_response(object, serializer, status = :ok)
      render json: serialize(object, serializer), status:
    end

    def json_pagination(objects, serializer, status = :ok)
      render json: {
        pagination: {
          found: objects.total_count,
          pages: objects.total_pages,
          current_page: objects.current_page,
          per_page: objects.limit_value
        },
        entries: serialize(objects, serializer)
      }, status:
    end

    private

    def serialize(objects, serializer)
      serializer.render_as_hash(objects)
    end

    def normalize_messages(messages)
      case messages
      when messages.is_a?(Array)
        messages.map { |m| normalize_messages(m) }.flatten
      when messages.is_a?(Hash)
        messages.keys.map do |key|
          value = messages[key]
          format('%<key>s %<value>s', key:, value: normalize_messages(value).join(','))
        end
      else
        [messages]
      end
    end

    def json_response_body(result, messages = [], data = nil)
      {
        result:,
        messages: normalize_messages(messages),
        data:
      }
    end
  end
end
